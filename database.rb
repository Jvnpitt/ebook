require "sinatra"

class Database
    attr_accessor :client

    def initialize(params = {})
        @@client = TinyTds::Client.new(username: params[:Username], password: params[:Password], host: params[:Host], port: params[:Port])

        if @@client.active?
            createDatabase()
            createBooksTable()
            createUsersTable()
            @@client.query_options[:symbolize_keys] = true
        end
    end

    def self.executeQuery(query)
        retQuery = @@client.execute(query)
        return retQuery
    end

    def createDatabase()
        query = "if not exists(select * from sys.databases where name = 'ESebo') CREATE DATABASE [ESebo]"
        @@client.execute(query)
    end

    def createBooksTable()
        # TODO: montar query
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Books') BEGIN CREATE TABLE Books (Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, Name NVARCHAR(50)) END"
        @@client.execute(query)
    end

    def createUsersTable()
        # TODO: montar query
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Users') BEGIN CREATE TABLE Books (Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, Name NVARCHAR(50)) END"
        @@client.execute(query)
    end
end