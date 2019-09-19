class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12
  include Pagy::Backend
  before_action :selection, only: :index
  decorates_assigned :book
  load_and_authorize_resource

  def index
    @pagy, @books = pagy(query_books.books_sort(@current_filter), items: BOOKS_PER_PAGE)
  end

  def show; end

  private

  def query_books
    BooksQuery.new(@books, @category)
  end

  def selection
    @current_filter = FilterService.new.call(params[:selection])
    @category = params[:category]
  end
end
