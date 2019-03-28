class BookPresenter < ApplicationPresenter
  def all_books_quantity
    Book.all.count
  end

  def authors_all(book)
    book.authors.map(&:name).join(', ')
  end
end
