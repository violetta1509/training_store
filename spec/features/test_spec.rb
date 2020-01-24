RSpec.describe "Test" do
  it 'checks pagination' do
    a = create(:category)
    create_list(:book, 15, category: a)
    visit('/')
    expect(page).to have_content('View More')
  end

  it 'checks empty page' do
    visit('/')
    expect(page).to have_content('Can`t find books')
    expect(page).to have_xpath("//img[@src='/assets/fallback/no_books-0a35a1b14b85c223a9d0c8bf0ea4cd29588f68cb35744963bb6c12d365118919.jpg']")
  end
end
