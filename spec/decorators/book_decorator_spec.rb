require 'spec_helper'

describe BookDecorator do
  let(:book) { create(:book, :with_author).decorate }

  it 'returns an array of stars' do
    expect(BookDecorator::RAITING_STARS).to eq([5, 4, 3, 2, 1])
  end

  it 'returns the review cuantity' do
    expect(book.reviews_quantity).to eq(0)
  end

  it 'returns authors of the book' do
    expect(book.authors_all).to eq("#{book.authors.first.first_name} #{book.authors.first.last_name}")
  end

  it 'returns shotr description of the book' do
    expect(book.short_description).to eq(book.description.first(100))
  end
end
