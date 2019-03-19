class SelectionByFilterService
  FILTERS = {
    created_at_desc: 'Newest first',
    popular_desc: 'Popular first',
    title_asc: 'Title A-Z',
    title_desc: 'Title Z-A',
    price_asc: 'Price: Low to high',
    price_desc: 'Price: High to low'
  }
  DEFAULT_FILTER = 'created_at_desc'

  def initialize(filter = nil)
    @filter = filter
  end

  def call
    @filter ? FILTERS[@filter.to_sym] : FILTERS[DEFAULT_FILTER.to_sym]
  end
end
