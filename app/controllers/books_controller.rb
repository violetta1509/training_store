class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12
  include Pagy::Backend
  decorates_assigned :book

  def index
    filter = params[:selection]
    @current_filter = BooksQuery::FILTERS.values.include?(filter) ? filter : BooksQuery::FILTERS[:created_at_desc]
    @category = params[:category]
    @pagy, @books = pagy(SelectBookService.new.call(books_params), items: BOOKS_PER_PAGE)
  end

  def show
    @book = Book.friendly.find(params[:id])
  end

  def books_params
    params.permit(:author_id, :max_price, :category, :selection)
  end
end
