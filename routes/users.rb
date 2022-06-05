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

            # GoHorse to put " on strings
            jUser.each do |k,v|
                if v.class == String
                    v.replace("\"#{v}\"")
                end
            end
            
            # TODO update on db and check columns
            query = "insert into Users (UserID, UserName, Login, Password, PasswordSalt) values (#{jUser[:UserID]},#{jUser[:UserName]},#{jUser[:Login]},#{jUser[:Password]}, #{jUser[:PasswordSalt]});"
            Database.executeQuery(query)
        end
    end
end


