class FilterService
  def call(filter)
    BooksQuery::FILTERS.values.include?(filter) ? filter : BooksQuery::FILTERS[:created_at_desc]
  end
end
