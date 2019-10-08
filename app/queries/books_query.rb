class BooksQuery
  FILTERS = {
    created_at_desc: I18n.t('filters.created_at_desc'),
    popular_desc: I18n.t('filters.popular_desc'),
    title_asc: I18n.t('filters.title_asc'),
    title_desc: I18n.t('filters.title_desc'),
    price_asc: I18n.t('filters.price_asc'),
    price_desc: I18n.t('filters.price_desc')
  }.freeze
  MAX_PRICE = 50
  MIN_PRICE = 0
  RUNNER_STEP = 0.1

  def initialize
    @books = Book.all
  end

  def call(params, sort_filter)
    books_by_author(params[:author_ids]) if params.include?(:author_ids)
    books_by_category(params[:category]) if params.include?(:category)
    books_by_price(params[:max_price]) if params.include?(:max_price)
    books_untill_date(params[:calendar]) if params.include?(:calendar)
    books_sort(sort_filter)
  end

  private

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
    @books = @books.where('price < ?', price)
  end

  def books_by_author(author_ids)
    book_ids = BooksAuthor.where(author_id: author_ids).map { |entity| entity.book.id }.uniq
    @books = Book.where(id: book_ids)
  end

  def books_by_category(category)
    @books = @books.where(category_id: category) if category
  end

  def books_untill_date(date)
    @books = @books.where('publication_year < ?', date.to_time.to_i)
  end
end
