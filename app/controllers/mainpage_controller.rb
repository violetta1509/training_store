class MainpageController < ApplicationController
  LAST_BOOKS_QUANTITY = 3
  BEST_SELLERS_IN_CATEGORY = 1
  decorates_assigned :book

  def homepage
    @best_sellers = BooksBestSellersService.new(BEST_SELLERS_IN_CATEGORY).call
    @new_books = Book.last(LAST_BOOKS_QUANTITY)
  end
end
