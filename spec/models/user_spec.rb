RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:reviews) }
    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:email) }
  end
end
