require 'pry'
class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12
  include Pagy::Backend
  before_action :default_selection, only: [:index]
  decorates_assigned :book

  def index
    @pagy, @books = pagy(GetBooksByCategoryService.new(params[:category], @current_filter).call, items: BOOKS_PER_PAGE)
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  private

  def default_selection
    @current_filter = SelectionByFilterService.new(params[:selection]).call
    @books_all = Book.all.count
    @categories = Category.all
    @all = params[:category] ? nil : true
  end
end
