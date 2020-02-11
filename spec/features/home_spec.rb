RSpec.describe 'Home' do
  let(:home_page) { HomePage.new }

  context 'without books' do

    before { visit '/' }

    it 'shows no books title' do
      expect(home_page.filters_title.text).to include('Filters')
      expect(home_page.catalog_title.text).to include('Catalog')
      expect(home_page.no_books_title.text).to include('Can`t find books')
    end
  end

  context 'with books' do
    let(:mob) { create(:category, title: 'Mobile development') }
    let(:web) { create(:category, title: 'Web development') }

    let!(:mob_books) { create_list(:book, 7, category: mob) }
    let!(:web_books) { create_list(:book, 6, category: web) }

    before { visit '/' }

    it 'shows all books' do
      home_page.view_more_button.click
      home_page.has_no_view_more_button?
      expect(home_page).to have_books(count: 13)
    end

    it 'shows pagination when more than 12 books created' do
      expect(home_page).to have_view_more_button
    end
  end
end
