class MainPageController < ApplicationController
  LAST_BOOKS_QUANTITY = 3
  BEST_SELLERS_IN_CATEGORY = 1
  before_action :set_header

  def homepage
    @best_sellers = BooksBestSellersService.new.call(BEST_SELLERS_IN_CATEGORY)
    @new_books = Book.last(LAST_BOOKS_QUANTITY)
  end

  private

  def set_header
    @book_presenter = BookPresenter.new(self)
    @header = HeaderPresenter.new(self)
  end
end
