require "sinatra"

class Database
    attr_accessor :client

    def initialize(params = {})
        @@client = TinyTds::Client.new(username: params[:Username], password: params[:Password], host: params[:Host], port: params[:Port])

        if @@client.active?
            createDatabase()
            createBooksTable()
            createUsersTable()
            createSessionTable()
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
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Books') BEGIN CREATE TABLE Books (BookID NVARCHAR(255),BookName NVARCHAR(255),SupplierID NVARCHAR(255),CategoryID NVARCHAR(255),QuantityPerUnit NVARCHAR(255),UnitPrice NVARCHAR(255),UnitsInStock NVARCHAR(255),UnitsOnOrder NVARCHAR(255),ReorderLevel NVARCHAR(255),Discontinued NVARCHAR(255)) END"
        @@client.execute(query).do
    end

    def createUsersTable()
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Users') BEGIN CREATE TABLE Users (UserID NVARCHAR(255), UserName NVARCHAR(255), Email NVARCHAR(255), Password NVARCHAR(255), PasswordSalt NVARCHAR(255)) END"
        @@client.execute(query).do
    end

    def createSessionTable()
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Session') BEGIN CREATE TABLE Session (UserID NVARCHAR(255), SessionValue NVARCHAR(255), Flag tinyint) END"
        @@client.execute(query).do
    end
end