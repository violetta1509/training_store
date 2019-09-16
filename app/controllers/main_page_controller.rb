class MainPageController < ApplicationController
  LAST_BOOKS_QUANTITY = 3
  BEST_SELLERS_IN_CATEGORY = 1

  def homepage
    @new_books = Book.last(LAST_BOOKS_QUANTITY)
    @best_sellers = BestSellresQuery.new.best_sellers
  end
end
