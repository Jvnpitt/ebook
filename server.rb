require "sinatra"

# require_relative "#{Dir.pwd}/routes/cart.rb"
require_relative "#{Dir.pwd}/routes/books.rb"
require_relative "#{Dir.pwd}/routes/users.rb"
require_relative "#{Dir.pwd}/routes/sessions.rb"
# require_relative "#{Dir.pwd}/routes/orders.rb"

class ESeboServer
    attr_accessor :port, :server

    def initialize(port)
        @@port = port

        server_config
        load_routes
    end

    def run!
        @@server.run!
    end

    def shutdown
        @@server.quit!
    end

    private
    def load_routes
        @@server.get '/' do
            erb :default_index
        end

        @@server.get '/books' do
            @allBooks = Routes::Books.getAll(request)
            erb :all_books
        end

        @@server.get '/books/:bookID' do
            @oneBook = Routes::Books.getOne(self)
            erb :one_book
        end

        @@server.post '/books' do
            @oneBook = Routes::Books.insert(request)
            # erb :one_book
        end

        # TODO Check if is necessary
        @@server.get '/users' do
            @allUsers = Routes::Users.getAll(request)
            erb :all_users
        end

        @@server.get '/users/:userID' do
            if Routes::Sessions.isValid?(request.cookies["esebosession"])
                @oneUser = Routes::Users.getOne(self)
                @oneUser.to_json.to_s
                # erb :one_user # TODO
            else
                "ERROR"
            end
        end

        # TODO add UI
        @@server.post '/users' do
            if Routes::Users.insert(request)
                return "OK"
            else
                return "ERROR"
            end
            # erb :register_user # TODO
        end

        @@server.post '/login' do
            newSession = Routes::Sessions.doLogin(request)
            unless newSession.nil?
                response.set_cookie("esebosession", :value => newSession.SessionValue.gsub("\"", ""),
                    :path => "/",
                    :httponly => true)
                    # :expires => Date.new(2020,1,1))
                return "OK"
            else
                return "ERROR"
            end
            # erb :register_user # TODO
        end

        @@server.error 400..510 do 
            erb :default_error
        end
    end

    def server_config
        @@server = Sinatra::Base

        @@server.before do
            headers "Server" => ''
            headers "Access-Control-Allow-Origin" => '*'
        end

        @@server.bind = '0.0.0.0'
        @@server.port = @@port
        @@server.mime_type :json
        @@server.mime_type :plain
        # For DBG
        # @@server.dump_errors = false
        # @@server.raise_errors = false
        # @@server.show_exceptions = false
        @@server.views = "#{Dir.pwd}/public/views"
        @@server.public_folder = "#{Dir.pwd}/public"
    end
end