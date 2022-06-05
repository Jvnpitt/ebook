### Example
#
# prodParams = { :UserID => 1234 }
# hProd = User.new(prodParams)
# hProd.UserName
# jProd = hProd.to_json
# jProd[:UserID]
#
###

require 'json'
require 'digest'
require 'securerandom'

class User
    attr_accessor :UserID, :UserName, :Login, :Password
    def initialize(params = {})
        # @UserID = params.fetch(:UserID, rand(0..99999))
        @UserID = rand(0..99999)
        @UserName = params.fetch(:UserName, "Lorem Ipsum #{@UserID}")
        @Login = params.fetch(:Login, rand(0..99999))
        @Password = params.fetch(:Password, rand(0..99999))
        @PasswordSalt = SecureRandom.uuid

        @Password = Digest::SHA512.hexdigest("#{@PasswordSalt}#{@Password}#{@PasswordSalt}")
    end

    def to_json
        { 
            :UserID =>  @UserID,
            :UserName => @UserName,
            :Login => @Login,
            :Password => @Password,
            :PasswordSalt => @PasswordSalt
        }
    end
end