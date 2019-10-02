class SelectBookService
  def call(params)
    return select_by_author(params) if params.include?(:author_id)
    return select_by_price(params) if params.include?(:max_price)

    select_by_category(params)
  end

  private

  def select_by_price(params)
    books = BooksQuery.new
    books.books_by_price(params[:max_price])
    # books.books_sort(false)
  end

  def select_by_category(params)
    books = BooksQuery.new(params[:category])
    books.books_by_category
    books.books_sort(false)
  end

  def select_by_author(params)
    books = BooksQuery.new
    books.books_by_author(params[:author_id])
    books.books_sort(false)
  end
end
