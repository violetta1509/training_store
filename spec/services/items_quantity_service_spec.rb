require 'rails_helper'

RSpec.describe ItemsQuantityService do
  let(:guest_items) { { '1': '1' } }
  let!(:order_item) { create(:order_item) }
  let!(:user) { order_item.order.user }
  let!(:order) { order_item.order }

  subject(:service) { described_class.new }
  context 'when guest have no items' do
    let(:guest_items) { {} }
    it { expect( service.call(guest_items, nil, nil) ).to eq(0) }
  end

  context 'when guest have items' do
    it { expect( service.call(guest_items, nil, nil) ).to eq(1) }
  end

  context 'when user have items' do
    it { expect( service.call(guest_items, user, order) ).to eq(1) }
  end

  context 'when add items to user' do
    let(:returned_order_item) { instance_double(CreateOrderItemService, call: true) }

    before do
      allow(CreateOrderItemService).to receive(:new).and_return(returned_order_item)
      service.call(guest_items, user, order)
    end

    it { expect(returned_order_item).to have_received(:call) }
  end
end
