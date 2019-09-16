require 'rails_helper'

RSpec.describe CreateOrderItemService do
  let!(:order_item) { create(:order_item) }
  let!(:order_id) { order_item.order_id }
  let!(:book_id) { order_item.book_id }
  let(:new_order) { create(:order) }
  let(:params) { { :book_id => order_item.book_id, :quantity => 1 } }

  subject(:service) { described_class.new }

  context 'when update order item' do
    it 'update item' do
      expect{ service.call(order_item.order_id,params) }.to change {
        OrderItem.find_by(order_id: order_id, book_id: book_id).quantity
      }.by(1)
    end
  end

  context 'when create order item' do
    it 'update item' do
      expect{ service.call(new_order.id, params) }.to change {
        OrderItem.all.count
      }.by(1)
    end
  end
end
