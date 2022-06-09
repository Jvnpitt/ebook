### Example
#
# userParams = { :UserID => 1234 }
# hUser = User.new(userParams)
# hUser.UserName
# jUser = hUser.to_json
# jUser[:UserID]
#
# # #
#
# POST /users HTTP/1.1
# Host: 127.0.0.1:9999

# {"UserName": "Teste 1", "Email" : "test@email.com", "Password": "1234"}
#
# # #
#
# GET /users/85060 HTTP/1.1
# Host: 127.0.0.1:9999
#
#
###

require_relative "#{Dir.pwd}/models/user.rb"

class Routes
    class Users
        def self.getAll(request)
            userList = []
            queryResult = Database.executeQuery("select * from Users")
            queryResult.each do |row|
                userList << User.new(row)
            end
            return userList
        end

        def self.getOne(request)
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
    
        def self.insert(request)
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)

            user = User.new(reqBody)
            jUser = user.to_json
            jUser[:Password] = BCrypt::Engine.hash_secret(jUser[:Password], jUser[:PasswordSalt])

            # GoHorse to put " on strings
            jUser.each do |k,v|
                if v.class == String
                    v.replace("\"#{v}\"")
                end
            end

            unless checkExistence(jUser[:Email])
                query = "insert into Users (UserID, UserName, Email, Password, PasswordSalt) values (#{jUser[:UserID]},#{jUser[:UserName]},#{jUser[:Email]},#{jUser[:Password]}, #{jUser[:PasswordSalt]});"
                
                ## TODO check why sometimes have error
                # binding.pry
                
                Database.executeQuery(query)
                return true
            else
                return false
            end
        end

        def self.checkExistence(email)
            query = "select * from Users where Users.Email = #{email.downcase}"

            queryResult = Database.executeQuery(query)
            ret = queryResult.first
            oneUser = User.new(ret) unless ret.nil?

            if oneUser.nil? 
                return false
            else
                return true
            end
        end
    end
end


