module BooksHelper
  include Pagy::Frontend

  def book_cover(book)
    book.images.first_or_initialize.image.url
  end

  def categories
    Category.all
  end

  def all_books_quantity
    Book.all.count
  end
end
