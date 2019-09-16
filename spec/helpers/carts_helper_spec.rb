RSpec.describe CartsHelper, type: :helper do
  describe "#order" do
    context 'when guest' do
      it "returns the default value" do
        expect(helper.order_summary).to eq({ coupon:0, subtotal: 0, total: 0 })
      end
    end

    context 'when user' do

      let(:user) { create(:user, :with_order) }

      it "returns the default title" do
        expect(helper.order_summary).to eq({ coupon: 0, subtotal: 0, total: 0 })
      end
    end
  end
end
