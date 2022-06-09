### Example
#
# prodParams = { :bookID => 1234 }
# hProd = Book.new(prodParams)
# hProd.BookName
# jProd = hProd.to_json
# jProd[:bookID]
#
###

require 'json'

class Book
    attr_accessor :BookID, :BookName, :AuthorName, :CategoryName, :UnitPrice, :UnitsInStock, :BookImgURL
    def initialize(params = {})
        @BookID = params.fetch(:BookID, rand(0..99999))
        @BookName = params.fetch(:BookName, "Lorem Ipsum #{@BookID}")
        @AuthorName = params.fetch(:AuthorName, rand(0..99999))
        @CategoryName = params.fetch(:CategoryName, rand(0..99999))
        @UnitPrice = params.fetch(:UnitPrice, rand.round(2) + rand(0..20))
        @UnitsInStock = params.fetch(:UnitsInStock, rand(0..200))
        @BookImgURL = params.fetch(:BookImgURL, "https://www.forewordreviews.com/books/covers/traveling-light.jpg")
    end

    def to_json
        { 
            :BookID =>  @BookID,
            :BookName => @BookName,
            :AuthorName => @AuthorName,
            :CategoryName => @CategoryName,
            :UnitPrice => @UnitPrice.to_f,
            :UnitsInStock => @UnitsInStock,
            :BookImgURL => @BookImgURL
        }
    end
end