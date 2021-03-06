require 'tiny_tds'

require_relative "#{Dir.pwd}/models/order.rb"

class Routes
    class Orders
        def self.getAll(request)

            query = "select * from Orders join OrderDetails as od on Orders.OrderID = od.OrderID join Books as pdc on od.BookID = pdc.BookID"

            arrOrderList = []
            bookList = []

            bookKeys = [:BookID, :BookName, :AuthorName, :CategoryName, :UnitPrice, :UnitsInStock]

            queryResult = Database.executeQuery(query)
            queryResult.each do |row|
                hBook = row.select { |key,_| bookKeys.include? key }
                row = Hash[row.to_a - hBook.to_a] #Go Horse to clear hash
                objBook = Book.new(hBook)
                hBook = {:OrderID => row[:OrderID], :Book => objBook}
                bookList << hBook
                arrOrderList << row unless arrOrderList.include? row
            end

            orderList = []
            arrOrderList.each do |order|
                orderList << Order.new(order)
            end

            orderList.each do |order|
                bookList.select do |bookByOrder|
                    if bookByOrder[:OrderID] == order.OrderID
                        order.BookList << bookByOrder[:Book]
                    end
                end
            end
            return orderList
        end

        def self.getOne(request)
            orderID = request.params[:orderID]

            query = "select * from Orders join OrderDetails as od on Orders.OrderID = od.OrderID join Books as pdc on od.BookID = pdc.BookID where Orders.OrderID = #{orderID}"

            orderList = []
            bookList = []

            bookKeys = [:BookID, :BookName, :AuthorName, :CategoryName, :UnitPrice, :UnitsInStock]

            queryResult = Database.executeQuery(query)
            queryResult.each do |row|
                hBook = row.select { |key,_| bookKeys.include? key }
                row = Hash[row.to_a - hBook.to_a] # Go Horse to clear hash
                objBook = Book.new(hBook)
                hBook = {:OrderID => row[:OrderID], :Book => objBook}
                bookList << hBook
                orderList << Order.new(row)
            end

            orderList.each do |order|
                bookList.each do |bookByOrder|
                    if bookByOrder[:OrderID] == order.OrderID
                        order.BookList << bookByOrder[:Book]
                        bookList.delete(bookByOrder)
                    end
                end
            end

            return orderList
        end
    
        def self.insert(request)
            request.body.rewind
            reqBody = JSON.parse(request.body.read, :symbolize_names => true)
<<<<<<< HEAD

            # get cart
            

            # TODO get from cart and add on db
            bookList.each do |book|
                queryOrderDetails = "insert into OrderDetails (OrderID, OrderDetailsID, BookID, BookQuantity), values (#{orderDetails[:OrderID]}, #{orderDetails[:OrderDetailsID]}, #{orderDetails[:BookID]}, #{orderDetails[:BookQuantity]})"

                queryResult = Database.executeQuery(query)
            end
=======
>>>>>>> 0e93e6460a914628d37d6926940b721167534626
        end
    end
end