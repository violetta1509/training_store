class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12
  include Pagy::Backend
  before_action :default_selection, only: :index
  before_action :set_header
  decorates_assigned :book

  def index
    @pagy, @books = pagy(GetBooksByCategoryService.new(params[:category], @current_filter).call, items: BOOKS_PER_PAGE)
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  private

  def set_header
    @header = HeaderPresenter.new(self)
  end

  def default_selection
    @current_filter = SelectionByFilterService.new(params[:selection]).call
    @book_presenter = BookPresenter.new(self)
    @categories = Category.all
    @all = params[:category] ? nil : true
  end
end
