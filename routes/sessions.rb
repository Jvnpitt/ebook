require_relative "#{Dir.pwd}/models/user.rb"
require_relative "#{Dir.pwd}/models/session.rb"

require 'digest'
require 'securerandom'

class Routes
    class Sessions
        def self.doLogin(request)
            newSession = nil
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)

            unless reqBody[:Email].nil?
                query = "select * from Users where Users.Email = \"#{reqBody[:Email]}\""
                
                begin
                    queryResult = Database.executeQuery(query)
                    oneUser = User.new(queryResult.first)

                    tmpSalt = oneUser.PasswordSalt || BCrypt::Engine.generate_salt
                    tmpPassword = reqBody[:Password] || BCrypt::Password.create(SecureRandom.hex(50))

                    ## User enumeration time based mitigation
                    tmpUserID = "XXXXX"
                    flag = 0 # false
                    
                    if oneUser.Password == BCrypt::Engine.hash_secret(tmpPassword, tmpSalt)
                        tmpUserID = oneUser.UserID
                        flag = 1 # true
                    end

                    newSession = Session.new({:UserID => tmpUserID, :Flag => flag})

                    if Sessions.sessionExist?(newSession.UserID)
                        Sessions.updateSessionValue(newSession.SessionValue, newSession.UserID)
                    else
                        Sessions.insert(newSession)
                    end
                    return newSession
                rescue => exception
                    ## Do nothing
                end
            end
        end

        def self.getUserIDFromSession(sessionValue)
            query = "select * from SessionList where SessionList.SessionValue = \"#{sessionValue}\""

            queryResult = Database.executeQuery(query)
            oneSession = Session.new(queryResult.first)

            return oneSession.UserID
        end

        def self.isValid?(sessionValue)
            query = "select * from SessionList where SessionList.SessionValue = \"#{sessionValue}\""

            queryResult = Database.executeQuery(query)
            oneSession = Session.new(queryResult.first)

            if 1 == oneSession.Flag
                return true
            else
                return false
            end
        end

        def self.updateSessionValue(sessionValue, userID)
            query = "UPDATE SessionList SET SessionList.SessionValue = '#{sessionValue}' WHERE SessionList.UserID = \"#{userID}\""
            Database.executeQuery(query)
        end

        def self.sessionExist?(userID)
            query = "select * from SessionList where SessionList.UserID = #{userID}"

            queryResult = Database.executeQuery(query)
            oneSession = Session.new(queryResult.first)

            if oneSession
                return true
            else
                return false
            end
        end
    
        def self.insert(session)
            jSession = session.to_json

            # GoHorse to put " on strings
            jSession.each do |k,v|
                if v.class == String
                    v.replace("\"#{v}\"")
                end
            end

            # TODO update on db and check columns with timestamp
            query = "insert into SessionList (UserID, SessionValue, Flag) values (#{jSession[:UserID]},#{jSession[:SessionValue]},#{jSession[:Flag]});"
            Database.executeQuery(query)
        end
    end
end


