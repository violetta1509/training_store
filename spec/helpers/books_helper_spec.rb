RSpec.describe ApplicationHelper, type: :helper do
  describe '#categories' do
    let(:user) { create(:user) }
    it 'all categoties' do
      expect(helper.categories).to be_kind_of(ActiveRecord::Relation)
    end

    it 'books quantity' do
      expect(helper.all_books_quantity).to be_kind_of(Integer)
    end
  end
end
