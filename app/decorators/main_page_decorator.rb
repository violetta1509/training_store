class MainPage < Draper::Decorator
  delegate_all

  def authors_all
    authors.map(&:name).join(', ')
  end
end