class BooksQuery
  FILTERS = {
    created_at_desc: I18n.t('filters.created_at_desc'),
    popular_desc: I18n.t('filters.popular_desc'),
    title_asc: I18n.t('filters.title_asc'),
    title_desc: I18n.t('filters.title_desc'),
    price_asc: I18n.t('filters.price_asc'),
    price_desc: I18n.t('filters.price_desc')
  }.freeze

  def initialize(category = false)
    @category = category
  end

  def books_sort(filter)
    case filter
    when FILTERS[:price_asc] then @books.order('price ASC')
    when FILTERS[:price_desc] then @books.order('price DESC')
    when FILTERS[:title_asc] then @books.order('title ASC')
    when FILTERS[:title_desc] then @books.order('title DESC')
    when FILTERS[:popular_desc] then @books.order('sold DESC')
    else
      @books.order('created_at DESC')
    end
  end

  def books_by_price(price)
    @books = Book.where('price < ?', price)
  end

  def books_by_author(author)
    @books = Author.find_by(id: author).books
  end

  def books_by_category
    @books = @category ? Category.friendly.find(@category).books : Book.all
  end

  def books_untill_date(date)
    @books = Book.where('publication_year < ?', date.to_time.to_i)
  end
end
