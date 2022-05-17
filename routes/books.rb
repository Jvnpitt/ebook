require_relative "#{Dir.pwd}/models/book.rb"

class Routes
    class Books
        def self.getAll(request)
            bookList = []
            queryResult = Database.executeQuery("SELECT * FROM Books")
            queryResult.each do |row|
                bookList << Book.new(row)
            end
            return bookList
        end

        def self.getOne(request)
            orderID = request.params[:bookID]

            query = "select * from Books where Books.BookID = #{orderID}"

            queryResult = Database.executeQuery(query)
            oneBook = Book.new(queryResult.first)
            return oneBook
        end
        
        def self.update(request)
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)
        end
    
        def self.insert(request)
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)
        end
    end
end

