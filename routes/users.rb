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

            # TODO update on db and check columns
            query = "insert into Users values XYZ"
            Database.executeQuery(query)
        end
    end
end


