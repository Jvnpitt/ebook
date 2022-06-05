require_relative "#{Dir.pwd}/models/user.rb"
require_relative "#{Dir.pwd}/models/session.rb"

require 'digest'
require 'securerandom'

class Routes
    class Sessions
        def self.doLogin(request)
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)

            unless reqBody[:Login].nil?
                query = "select * from Users where Users.UserID = #{userID}"
                
                begin
                    queryResult = Database.executeQuery(query)
                    oneUser = User.new(queryResult.first)

                    tmpPassword = reqBody[:Password] || "#{SecureRandom.hex(50)}"
                    tmpSalt = oneUser.PasswordSalt || "#{SecureRandom.hex(50)}"

                    ## User enumeration time based mitigation
                    tmpUserID = "XXXXX"
                    flag = 0 # false
                    
                    if oneUser.Password == Digest::SHA512.hexdigest("#{tmpSalt}#{tmpPassword}#{tmpSalt}")
                        tmpUserID = oneUser.UserID
                        flag = 1 # true
                    end

                    newSession = Session.new({:UserID => tmpUserID, :Flag => flag})
                    Sessions.insert(newSession)
                rescue => exception
                    ## Do nothing
                end
            end
        end

        def self.generateSession(request)
            userID = request.params[:userID]

            query = "select * from Users where Users.UserID = #{userID}"

            queryResult = Database.executeQuery(query)
            oneUser = User.new(queryResult.first)
            return oneUser
        end
        
        def self.update(request)
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)
            # TODO check session
            # TODO update on db and check columns
            query = "insert into Users values XYZ"
            Database.executeQuery(query)
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
            query = "insert into Users (UserID, SessionToken, Flag) values (#{jSession[:UserID]},#{jSession[:SessionToken]},#{jSession[:Flag]});"
            Database.executeQuery(query)
        end
    end
end


