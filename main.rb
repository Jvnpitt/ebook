require 'bundler/setup'
require 'sinatra'
require 'json'
require 'yaml'
require 'base64'
require 'tiny_tds'
require 'mysql2'

require_relative 'server.rb'
require_relative 'database.rb'

## For dbg mode
require 'pry'
# DataMapper::Logger.new($stdout, :debug)

class ESeboMain
    attr_accessor :server, :database, :bash

    def initialize(params = {})
        initialize_directories
        @@database = Database.new(params.fetch(:Database, {}))
        @@server = ESeboServer.new(params.fetch(:ServerPort, 8080))
    end

    def init_server
        @@server.run!
    end

    def server_shutdown
        @@server.shutdown
    end

    private
    def initialize_directories
        private_dir = "#{Dir.pwd}/Private"
        [private_dir, 
            "#{private_dir}/Logs",
            "#{private_dir}/Database"].each { |dir| Dir.mkdir(dir) unless Dir.exist?(dir) }
    end
end

config = YAML.load_file('config/config.yml')

ntwServer = ESeboMain.new(config)

ntwServer.server_shutdown