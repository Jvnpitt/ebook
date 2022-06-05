### Example
#
#
###

require 'date'
require 'json'
require 'securerandom'

class OrderDetails
    attr_accessor :OrderID
    def initialize(params = {})
        @OrderID = params.fetch(:OrderID)
    end

    def to_json
        { 
            :OrderID => @OrderID,
        }
    end
end