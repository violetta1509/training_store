require 'rails_helper'

RSpec.describe BooksQuery do
  subject(:query) { described_class }

  let(:best_book_1) { create(:book, title: 'Aaaaa', price: 3, sold: 1) }
  let(:best_book_2) { create(:book, title: 'Bbbbb', price: 2, sold: 5) }
  let(:best_book_3) { create(:book, title: 'Ccccc', price: 1, sold: 3) }

  context 'when update order item' do
    before do
      best_book_1
      best_book_2
      best_book_3
    end

    it 'A-Z sort' do
      expect(query.new.books_sort(I18n.t('filters.title_asc'))).to eq([best_book_1, best_book_2, best_book_3])
    end

    it 'Z-A sort' do
      expect(query.new.books_sort(I18n.t('filters.title_desc'))).to eq([best_book_3, best_book_2, best_book_1])
    end

    it 'Sort price: Low to high' do
      expect(query.new.books_sort(I18n.t('filters.price_asc'))).to eq([best_book_3, best_book_2, best_book_1])
    end

    it 'Sort price: High to low' do
      expect(query.new.books_sort(I18n.t('filters.price_desc'))).to eq([best_book_1, best_book_2, best_book_3])
    end

    it 'Default sort' do
      expect(query.new.books_sort('')).to eq([best_book_3, best_book_2, best_book_1])
    end

    it 'Default sort' do
      expect(query.new.books_sort(I18n.t('filters.popular_desc'))).to eq([best_book_2, best_book_3, best_book_1])
    end
  end
end
