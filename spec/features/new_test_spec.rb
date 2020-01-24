RSpec.describe "Home" do

  context "when categories list is shown" do
  it 'when we dont have books' do
    visit('/')
    within 'main ul.list-inline' do
      expect(page).to have_content('All')
      expect(page).to have_content('0')
    end
  end

  it 'when we have books with different categories' do
  end
  end
end