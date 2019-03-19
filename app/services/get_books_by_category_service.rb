require 'pry'
class GetBooksByCategoryService
  def initialize(category_id, current_filter)
    @filter = current_filter
    @category_id = category_id
  end

  def call
    return make_selection(Book.where(category_id: @category_id)) if @category_id
    make_selection(Book.all)
  end

  private

  def make_selection(entities)
    entities.selection_by_order(SelectionByFilterService::FILTERS.key(@filter).to_s)
  end
end
