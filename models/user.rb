### Example
#
# userParams = { :UserID => 1234 }
# hUser = User.new(userParams)
# hUser.UserName
# jUser = hUser.to_json
# jUser[:UserID]
#
# # #
#
# POST /users HTTP/1.1
# Host: 127.0.0.1:9999

# {"UserName": "Teste 1", "Email" : "test@email.com", "Password": "1234"}
#
# # #
#
# GET /users/85060 HTTP/1.1
# Host: 127.0.0.1:9999
#
#
###

require 'json'
require 'digest'
require 'securerandom'

class User
    attr_accessor :UserID, :UserName, :Email, :Password
    def initialize(params = {})
        # @UserID = params.fetch(:UserID, rand(0..99999))
        @UserID = rand(0..99999)
        @UserName = params.fetch(:UserName, "Lorem Ipsum #{@UserID}")
        @Email = params.fetch(:Email, "test-#{rand(0..99999)}@email.com") ## login
        @Password = params.fetch(:Password, rand(0..99999))
        @PasswordSalt = SecureRandom.uuid

        @Password = Digest::SHA512.hexdigest("#{@PasswordSalt}#{@Password}#{@PasswordSalt}")
    end

    def to_json
        { 
            :UserID =>  @UserID,
            :UserName => @UserName,
            :Email => @Email,
            :Password => @Password,
            :PasswordSalt => @PasswordSalt
        }
    end
end