class BookDecorator < Draper::Decorator
  delegate_all
  DESCRIPTION_IN_RANGE = 100
  RAITING_STARS = [5, 4, 3, 2, 1]

  def authors_all
    authors.map(&:name).join(', ')
  end

  def short_description
    description.first(DESCRIPTION_IN_RANGE)
  end

  def stars
    RAITING_STARS
  end

  def reviews_quantity
    all_reviews.approved.count
  end

  def all_reviews
    @reviews ||= reviews
  end
end
