class MainpageController < ApplicationController
  LAST_BOOKS_QUANTITY = 3
  BEST_SELLERS_IN_CATEGORY = 1
  before_action :set_book_presenter

  def homepage
    @best_sellers = BooksBestSellersService.new(BEST_SELLERS_IN_CATEGORY).call
    @new_books = Book.last(LAST_BOOKS_QUANTITY)
  end

  private

  def set_book_presenter
    @book_presenter = BookPresenter.new(self)
  end
end
