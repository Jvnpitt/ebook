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

class User
    attr_accessor :UserID, :UserName, :SupplierID, :CategoryID, :QuantityPerUnit, :UnitPrice, :UnitsInStock, :UnitsOnOrder, :ReorderLevel, :Discontinued
    def initialize(params = {})
        @UserID = params.fetch(:UserID, rand(0..99999))
        @UserName = params.fetch(:UserName, "Lorem Ipsum #{@UserID}")
        @SupplierID = params.fetch(:SupplierID, rand(0..99999))
        @CategoryID = params.fetch(:CategoryID, rand(0..99999))
        @QuantityPerUnit = params.fetch(:QuantityPerUnit, ["10 boxes x 20 bags", "24 - 12 oz bottles", "12 - 550 ml bottles", "48 - 6 oz jars", "36 boxes", "18 - 500 g pkgs.", "50 bags x 30 sausgs.", "16 pies", "15 - 300 g rounds"].shuffle.first)
        @UnitPrice = params.fetch(:UnitPrice, rand.round(2) + rand(0..20))
        @UnitsInStock = params.fetch(:UnitsInStock, rand(0..200))
        @UnitsOnOrder = params.fetch(:UnitsOnOrder, 0)
        @ReorderLevel = params.fetch(:ReorderLevel, 0)
        @Discontinued = params.fetch(:Discontinued, 0)
    end

    def to_json
        { 
            :UserID =>  @UserID,
            :UserName => @UserName,
            :SupplierID => @SupplierID,
            :CategoryID => @CategoryID,
            :QuantityPerUnit => @QuantityPerUnit,
            :UnitPrice => @UnitPrice.to_f,
            :UnitsInStock => @UnitsInStock,
            :UnitsOnOrder => @UnitsOnOrder,
            :ReorderLevel => @ReorderLevel,
            :Discontinued => @Discontinued
        }
    end
end