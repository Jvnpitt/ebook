### Example
#
#
###

require 'date'
require 'json'
require 'securerandom'

class Cart
    attr_accessor :UserID, :TemporaryOrderID
    def initialize(params = {})
        @UserID = params.fetch(:UserID)
        @TemporaryOrderID = SecureRandom.uuid
    end

    def to_json
        { 
            :UserID => @UserID,
            :TemporaryOrderID => @TemporaryOrderID
        }
    end
end