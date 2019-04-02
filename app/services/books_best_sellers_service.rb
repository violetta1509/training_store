class BooksBestSellersService
  def call(amount_books)
    @best_sellers = []
    categories = [*1..Category.all.count]
    categories.map(&method(:best_books))
    @best_sellers.flatten
  end

  private

  def best_books(category_id)
    @best_sellers << Category.find(category_id).books.best_sellers.first
  end
end
