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
            createOrderTable()
            createOrderDetailsTable()
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
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Books') BEGIN CREATE TABLE Books (BookID NVARCHAR(255), BookImgURL NVARCHAR(255),BookName NVARCHAR(255),AuthorName NVARCHAR(255),CategoryName NVARCHAR(255),UnitPrice Float,UnitsInStock int) END"
        @@client.execute(query).do
    end

    def createUsersTable()
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Users') BEGIN CREATE TABLE Users (UserID NVARCHAR(255), UserName NVARCHAR(255), Email NVARCHAR(255), Password NVARCHAR(255), PasswordSalt NVARCHAR(255)) END"
        @@client.execute(query).do
    end

    def createSessionTable()
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'SessionList') BEGIN CREATE TABLE SessionList (UserID NVARCHAR(255), SessionValue NVARCHAR(255), Flag tinyint) END"
        @@client.execute(query).do
    end

    def createOrderTable()
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Orders') BEGIN CREATE TABLE Orders (OrderID NVARCHAR(255), UserID NVARCHAR(255), OrderDetailsID NVARCHAR(255), OrderDate NVARCHAR(255), OrderValue FLOAT) END"
        @@client.execute(query).do
    end

    def createOrderDetailsTable()
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'OrderDetails') BEGIN CREATE TABLE OrderDetails (OrderID NVARCHAR(255), OrderDetailsID NVARCHAR(255), BookID NVARCHAR(255), BookQuantity int) END"
        @@client.execute(query).do
    end
    
    def createCartsTable()
        query = "USE ESebo; IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Carts') BEGIN CREATE TABLE Carts (CartID NVARCHAR(255), UserID NVARCHAR(255), BookID NVARCHAR(255), BookQuantity int) END"
        @@client.execute(query).do
    end
end