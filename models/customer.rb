### Example
#
#
###

require 'json'

class Customer
    attr_accessor :CustomerID, :CompanyName, :ContactName, :ContactTitle, :Address, :City, :Region, :PostalCode, :Country, :Phone, :Fax
    def initialize(params = {})
        @CustomerID = params.fetch(:CustomerID, rand(0..99999).to_s)
        @CompanyName = params.fetch(:CompanyName, "Company Name #{Time.now.to_i.to_s}")
        @ContactName = params.fetch(:ContactName, "Contact Name #{Time.now.to_i.to_s}")
        @ContactTitle = params.fetch(:ContactTitle, "Contact Title #{Time.now.to_i.to_s}")
        @Address = params.fetch(:Address, "Address #{Time.now.to_i.to_s}")
        @City = params.fetch(:City, "Berlin")
        @Region = params.fetch(:Region, nil)
        @PostalCode = params.fetch(:PostalCode, "Code")
        @Country = params.fetch(:Country, "Germany")
        @Phone = params.fetch(:Phone, "#{Time.now.to_i.to_s}")
        @Fax = params.fetch(:Fax, "#{Time.now.to_i.to_s}")
    end

    def to_json
        { 
            :CustomerID => @CustomerID,
            :CompanyName => @CompanyName,
            :ContactName => @ContactName,
            :ContactTitle => @ContactTitle,
            :Address => @Address,
            :City => @City,
            :Region => @Region,
            :PostalCode => @PostalCode,
            :Country => @Country,
            :Phone => @Phone,
            :Fax => @Fax
        }
    end
end