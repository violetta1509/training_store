class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12
  include Pagy::Backend
  decorates_assigned :book

  def index
    filter = params[:selection]
    @current_filter = BooksQuery::FILTERS.values.include?(filter) ? filter : BooksQuery::FILTERS[:created_at_desc]
    @category = params[:category]
    @pagy, @books = pagy(BooksQuery.new(@category).books_sort(@current_filter), items: BOOKS_PER_PAGE)
  end

  def show
    @book = Book.friendly.find(params[:id])
  end
end
