require 'rails_helper'

RSpec.describe OrderItemsService do

  subject(:service) { described_class.new(current_user, params) }

  context 'when show order_items of user' do
    let!(:current_user) { create(:user, :with_order) }
    let(:params) { {} }
    let(:order_item) { current_user.orders.first.order_items.first }

    it { expect(service.call).to eq({ order_item.book => order_item.quantity }) }
  end

  context 'when show order_items of guest' do
    let!(:book) { create(:book) }
    let!(:current_user) { nil }
    let(:params) { { "#{book.id}" => '2' } }

    it { expect(service.call).to eq({ book => '2' }) }
  end
end
