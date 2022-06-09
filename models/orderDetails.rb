### Example
#
#
###

require 'date'
require 'json'
require 'securerandom'

class OrderDetails
    attr_accessor :OrderID, :OrderDetailsID, :BookID, :BookQuantity
    def initialize(params = {})
        @BookID = params.fetch(:BookID, rand(0..99999))
        @OrderID = params.fetch(:OrderID, rand(0..99999))
        @BookQuantity = params.fetch(:BookQuantity, 1)
        @OrderDetailsID = params.fetch(:OrderDetailsID, rand(0..99999))
    end

    def to_json
        { 
            :BookID => @BookID,
            :OrderID => @OrderID,
            :BookQuantity => @BookQuantity,
            :OrderDetailsID => @OrderDetailsID
        }
    end
end