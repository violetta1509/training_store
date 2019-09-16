RSpec.describe ApplicationController, type: :controller do
  describe '.current_order' do
    let(:user) { create(:user, :with_order) }

    before do
      login_user(user)
    end

    it 'take current order' do
      expect(controller.current_order).to eq(user.orders.in_progress.first)
    end
  end
end
