require_relative "#{Dir.pwd}/models/book.rb"

class Routes
    class Books
        def self.getAll(request)
            bookList = []
            query = "select * from Books"
            queryResult = Database.executeQuery(query)
            queryResult.each do |row|
                bookList << Book.new(row)
            end
            return bookList
        end

        def self.getOne(request)
            bookID = request.params[:bookID]

            query = "select * from Books where Books.BookID = #{bookID}"

            queryResult = Database.executeQuery(query)
            oneBook = Book.new(queryResult.first)
            return oneBook
        end

        def self.search(request)
            bookList = []

            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)

            bookName = reqBody[:BookName]

            query = "select * from Books where Books.BookName LIKE '%#{bookName}%'"

            queryResult = Database.executeQuery(query)
            unless queryResult.nil?
                queryResult.each do |row|
                    bookList << Book.new(row)
                end
            end
            return bookList
        end
        
        def self.update(request)
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)
        end
    
        def self.insert(request)
            reqBody = {}
            request.body.rewind
            
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)

            
            book = Book.new(reqBody)
            jBook = book.to_json

            # GoHorse to put " on strings
            jBook.each do |k,v|
                if v.class == String
                    v.replace("\"#{v}\"")
                end
            end

            query = "insert into Books (BookID, BookName, AuthorName, CategoryName, UnitPrice, UnitsInStock, BookImgURL, BookDescription) values (#{jBook[:BookID]},#{jBook[:BookName]},#{jBook[:AuthorName]},#{jBook[:CategoryName]},#{jBook[:UnitPrice]},#{jBook[:UnitsInStock]},#{jBook[:BookImgURL]}, #{jBook[:BookDescription]});"

            queryResult = Database.executeQuery(query)
        end
    end
end


