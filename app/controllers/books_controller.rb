class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12
  include Pagy::Backend
  decorates_assigned :book
  before_action :assign_variables, only: :index

  def index
    @pagy, @books = pagy(BooksQuery.new.call(params, @current_filter), items: BOOKS_PER_PAGE)
  end

  def show
    @book = Book.friendly.find(params[:id])
  end

  def books_params
    params.permit(:author_ids, :max_price, :category, :selection, :calendar)
  end

  private

  def assign_variables
    @price = books_params[:max_price] || 50
    @authors = params[:author_ids] || []
    @category = books_params[:category]
    sort_filter = books_params[:selection]
    @calendar = books_params[:calendar] || Time.zone.now.strftime('%Y/%d/%m').to_s
    @current_filter = BooksQuery::FILTERS.values.include?(sort_filter) ? sort_filter : BooksQuery::FILTERS[:created_at_desc]
  end
end
