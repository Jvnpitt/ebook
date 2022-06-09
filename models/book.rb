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
    attr_accessor :BookID, :BookName, :AuthorName, :CategoryName, :UnitPrice, :UnitsInStock, :BookImgURL, :BookDescription
    def initialize(params = {})
        @BookID = params.fetch(:BookID, rand(0..99999))
        @BookName = params.fetch(:BookName, "Lorem Ipsum #{@BookID}")
        @AuthorName = params.fetch(:AuthorName, rand(0..99999))
        @CategoryName = params.fetch(:CategoryName, rand(0..99999))
        @UnitPrice = params.fetch(:UnitPrice, rand.round(2) + rand(0..20))
        @UnitsInStock = params.fetch(:UnitsInStock, rand(0..200))
        @BookImgURL = params.fetch(:BookImgURL, "https://www.forewordreviews.com/books/covers/traveling-light.jpg")
        @BookDescription = params.fetch(:BookDescription, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    end

    def to_json
        { 
            :BookID =>  @BookID,
            :BookName => @BookName,
            :AuthorName => @AuthorName,
            :CategoryName => @CategoryName,
            :UnitPrice => @UnitPrice.to_f,
            :UnitsInStock => @UnitsInStock,
            :BookImgURL => @BookImgURL,
            :BookDescription => @BookDescription
        }
    end
end