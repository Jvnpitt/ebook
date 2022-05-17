### Example
#
#
###

require 'date'
require 'json'

class Order
    attr_accessor :OrderID, :CustomerID, :EmployeeID, :OrderDate, :RequiredDate, :ShippedDate, :ShipVia, :Freight, :ShipName, :ShipAddress, :ShipCity, :ShipRegion, :ShipPostalCode, :ShipCountry, :bookList
    def initialize(params = {})
        @OrderID = params.fetch(:OrderID, rand(0..99999))
        @CustomerID = params.fetch(:CustomerID, rand(0..99999))
        @EmployeeID = params.fetch(:EmployeeID, rand(0..99999))
        @OrderDate = params.fetch(:OrderDate, Time.now.to_s)
        @RequiredDate = params.fetch(:RequiredDate, Time.now.to_i.to_s)
        @ShippedDate = params.fetch(:ShippedDate, Time.now.to_i.to_s)
        @ShipVia = params.fetch(:ShipVia, "#{Time.now.to_i.to_s}")
        @Freight = params.fetch(:Freight, rand(0..200))
        @ShipName = params.fetch(:ShipName, "Ship Name #{Time.now.to_i.to_s}")
        @ShipAddress = params.fetch(:ShipAddress, "Ship Address #{Time.now.to_i.to_s}")
        @ShipCity = params.fetch(:ShipCity, "Ship City #{Time.now.to_i.to_s}")
        @ShipRegion = params.fetch(:ShipRegion,  "Ship Region #{Time.now.to_i.to_s}")
        @ShipPostalCode = params.fetch(:ShipPostalCode,  "Ship PostalCode #{Time.now.to_i.to_s}")
        @ShipCountry = params.fetch(:ShipCountry,  "Ship Country #{Time.now.to_i.to_s}")
        @bookList = params.fetch(:bookList, [])
    end

    def to_json
        { 
            :OrderID => @OrderID,
            :CustomerID => @CustomerID,
            :EmployeeID => @EmployeeID,
            :OrderDate => @OrderDate,
            :ShippedDate => @ShippedDate,
            :ShipVia => @ShipVia,
            :Freight => @Freight,
            :ShipName => @ShipName,
            :ShipAddress => @ShipAddress,
            :ShipCity => @ShipCity,
            :ShipRegion => @ShipRegion,
            :ShipPostalCode => @ShipPostalCode,
            :ShipCountry => @ShipCountry,
            :bookList => @bookList
        }
    end
end