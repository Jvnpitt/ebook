### Example
#
#
###

require 'json'

class Cart
    attr_accessor :UserID, :BookID, :CartID, :BookQuantity, :BookList
    def initialize(params = {})
        @BookList = params.fetch(:BookList, [])
        @CartID = params.fetch(:CartID, rand(0..99999))
        @UserID = params.fetch(:UserID)
        @BookID = params.fetch(:BookID)
        @BookQuantity = params.fetch(:BookQuantity, 1)
    end

    def to_json
        {
            :CartID => @CartID, 
            :UserID => @UserID,
            :BookID => @BookID,
            :BookList => @BookList,
            :BookQuantity => @BookQuantity
        }
    end
end