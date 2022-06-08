### Example
#
#
###

require 'date'
require 'json'
require 'securerandom'

class Session
    attr_accessor :UserID, :SessionValue, :Flag
    def initialize(params = {})
        @Flag = params.fetch(:Flag, 0)
        @UserID = params.fetch(:UserID)
        @SessionValue = params.fetch(:SessionValue, "#{SecureRandom.uuid}#{SecureRandom.hex(13)}#{SecureRandom.uuid}")
    end

    def to_json
        { 
            :UserID => @UserID,
            :SessionValue => @SessionValue,
            :Flag => @Flag
        }
    end
end