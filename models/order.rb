### Example
#
#
###

require 'date'
require 'json'

class Order
    attr_accessor :OrderID, :UserID, :OrderDate, :OrderDetailsID, :OrderValue, :BookList
    def initialize(params = {})
        @BookList = params.fetch(:BookList, [])
        @UserID = params.fetch(:UserID, rand(0..99999))
        @OrderID = params.fetch(:OrderID, rand(0..99999))
        @OrderDate = params.fetch(:OrderDate, Time.now.to_s)
        @OrderValue = params.fetch(:OrderValue, rand(0..99999))
        @OrderDetailsID = params.fetch(:OrderDetailsID, rand(0..99999))
    end

    def to_json
        { 
            :BookList => @BookList, 
            :UserID => @UserID,
            :OrderID => @OrderID,
            :OrderDate => @OrderDate,
            :OrderValue => @OrderValue,
            :OrderDetailsID => @OrderDetailsID
        }
    end
end