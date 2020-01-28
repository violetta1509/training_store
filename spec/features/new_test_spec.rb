#RSpec.describe 'Home' do
#  context "when categories list is shown" do
#    it 'when we dont have books' do
#      page = SignUp.new
#      page.load
#      within 'ul.list-inline' do
#        expect(page).to have_content('All')
#        expect(page).to have_content('0')
#      end
#    end
#    it 'when we have books with different categories' do
#      create_list(:book, 10, category: create(:category))
#      page = SignUp.new
#      page.load
#      binding.pry
#    end
#  end
#end