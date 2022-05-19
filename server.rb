require "sinatra"

require_relative "#{Dir.pwd}/routes/books.rb"

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

        # TODO Check if is necessary
        @@server.get '/users' do
            @allUsers = Routes::Users.getAll(request)
            erb :all_users
        end

        # TODO add UI
        @@server.post '/users' do
            Routes::Users.insert(request)
            redirect '/success'
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