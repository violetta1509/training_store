class BooksBestSellersService
  def initialize(number)
    @amount_books_in_category = number
  end

  def call
    best_sellers = []
    numbers_array = [*1..Category.all.count]
    numbers_array.each do |num|
      best_sellers << Category.find(num).books.best_sellers.first(@amount_books_in_category)
    end
      best_sellers = best_sellers.flatten
  end
end
