RSpec.describe ApplicationHelper, type: :helper do
  describe '#items_quantity' do
    it 'items quantity' do
      expect(helper.items_quantity).to be_kind_of(Integer)
    end
  end
end
