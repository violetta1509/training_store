RSpec.describe Author, type: :model do
  describe 'associations' do
    it { should have_many(:booksAuthors) }
    it { should have_many(:books) }
  end
end
