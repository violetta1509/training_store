require 'rails_helper'

RSpec.describe ConfirmOrResetCouponService do
  let(:order) { coupon.order }
  subject(:service) { described_class.new }


  context 'when total more then the coupon' do
    let!(:coupon) { create(:coupon, value: '1', active: false) }
    before do
      order.update(total: 10)
    end

    it 'take stock coupon to order total' do
        expect{ service.call(order, coupon) }.to change { order.total }.by(-1)
    end
  end

  context 'when total less or equal the coupon' do
    let!(:coupon) { create(:coupon, value: '10', active: false) }

    before do
      order.update(total: 1, coupon_id: coupon.id)
    end

    it 'reset coupon from order' do
      expect{ service.call(order, coupon) }.to change { order.coupon_id }.from(coupon.id).to(nil)
    end

    context 'active coupon' do
      it { expect{ service.call(order, coupon) }.to change { Coupon.find_by(id: coupon.id).active }.from(false).to(true) }
      it { expect{ service.call(order, coupon) }.to change { Coupon.find_by(id: coupon.id).order_id }.from(order.id).to(nil) }
    end
  end
end
