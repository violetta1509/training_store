require 'rails_helper'

RSpec.describe SummaryService do
  let!(:book) { create(:book) }
  let(:guest_items) { {} }
  let(:coupon) { create(:coupon, order: nil) }
  let(:current_order) { user.orders.in_progress.first }
  let(:total) { current_order.total }

  subject(:service) { described_class.new }

  context 'when apply coupon which more when subtotal' do
    it 'guest apply coupon' do
      expect( service.call(nil, guest_items, coupon.id, nil) ).to eq({ coupon: coupon.value, subtotal: 0, total: 0})
    end
  end

  context 'when apply coupon which less when subtotal' do
    let(:guest_items) { { book.id.to_s => '100' } }
    let(:subtotal_value) { (book.price * guest_items[book.id.to_s].to_i).round(2) }
    let(:total_value) { (subtotal_value - coupon.value).round(2) }

    it 'guest apply coupon' do
      expect( service.call(nil, guest_items, coupon.id, nil) ).to eq({ coupon: coupon.value, subtotal: subtotal_value, total: total_value})
    end
  end

  context 'when user have not a coupon' do
    let(:coupon) { 0 }
    let!(:user) { create(:user, :with_order) }

    it 'guest have not a coupon' do
      expect( service.call(user, nil, nil, current_order) ).to eq({ coupon: coupon, subtotal: current_order.total, total: total })
    end
  end

  context 'when user have a coupon' do
    let(:coupon) { current_order.coupon.value }
    let!(:user) { create(:user, :with_order_coupon) }

    it 'guest have not a coupon' do
      expect( service.call(user, nil, nil, current_order) ).to eq({ coupon: coupon, subtotal: current_order.total, total: total})
    end
  end
end
