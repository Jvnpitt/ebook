require_relative "#{Dir.pwd}/models/book.rb"
require_relative "#{Dir.pwd}/models/cart.rb"
require_relative "#{Dir.pwd}/models/order.rb"

require_relative "#{Dir.pwd}/routes/books.rb"
require_relative "#{Dir.pwd}/routes/orders.rb"
require_relative "#{Dir.pwd}/routes/sessions.rb"

class Routes
    class Carts
        def self.getCart(request)
            userID = Routes::Sessions.getUserIDFromSession(request.cookies["esebosession"])
            
            query = "select * from Carts where Carts.CartID = #{userID}"
            queryResult = Database.executeQuery(query)
        end

        def self.addToCart(request)
            userID = Routes::Sessions.getUserIDFromSession(request.request.cookies["esebosession"])
            bookID = request.params[:bookID]
            cart = Cart.new(:CartID => userID, :UserID => userID, :BookID => bookID)

            Carts.insert(cart)
        end

        # TODO
        def self.removeFromCart(request)
            cartID = nil
            reqBody = {}
            request.body.rewind
            
            reqBody = JSON.parse(request.body.read, :symbolize_names => true) # unless request.body.read.empty?

            bookID = reqBody["BookID"]
            bookQuantity = reqBody["BookQuantity"]
            userID = Routes::Sessions.getUserIDFromSession(request.cookies["esebosession"])

            cart = Cart.new(UserID => userID, BookID => bookID, BookQuantity => bookQuantity)
            
            Cart.remove(cart)
        end
    
        def self.insert(cart)
            query = "insert into Carts (UserID, CartID, BookID, BookQuantity) values (#{cart.UserID},#{cart.CartID},#{cart.BookID},#{cart.BookQuantity});"
            Database.executeQuery(query)
        end

        def self.remove(cart)
            jCart = cart.to_json

            # GoHorse to put " on strings
            jCart.each do |k,v|
                if v.class == String
                    v.replace("\"#{v}\"")
                end
            end

            # TODO update on db and check columns
            #query = "delete from Carts where (select * from insert into Carts (CartID, UserID, BookID, BookQuantity) values (#{jCart[:CartID]}, #{jCart[:UserID]},#{jCart[:BookID]}, #{jCart[:BookQuantity]});"
            # Database.executeQuery(query)
        end
    end
end