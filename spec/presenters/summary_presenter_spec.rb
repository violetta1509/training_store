describe SummaryPresenter do
  let!(:order_without_coupon) { create(:order) }
  let!(:coupon) { create(:coupon) }

  it '#subtotal order' do
    allow(subject.instance_variable_set(:@order, order_without_coupon))
    expect(subject.subtotal_order).to eq(order_without_coupon.total)
  end

  describe '#coupon_order' do
    context 'when call coupon_order' do
      it 'coupon presence' do
        allow(subject.instance_variable_set(:@coupon, coupon))
        expect(subject.coupon_order).to eq(coupon.value)
      end

      it 'without coupon' do
        allow(subject.instance_variable_set(:@coupon, nil))
        expect(subject.coupon_order).to eq(0)
      end
    end
  end

  describe '#total_order' do
    context 'when call total_order' do
      context 'when order in payment' do
        let!(:order_with_coupon) { create(:order, :with_coupon) }
        let(:coupon) { order_with_coupon.coupon }
        let(:delivery_service) { order_with_coupon.delivery_service }
        let(:total) { order_with_coupon.total - coupon.value }

        before do
          order_with_coupon.update(total: 10)
          coupon.update(value: 1)
          order_with_coupon.to_delivery!
          order_with_coupon.to_payment!
          allow(subject.instance_variable_set(:@order, order_with_coupon))
          allow(subject.instance_variable_set(:@coupon, coupon))
        end

        it { expect(subject.total_order).to eq((total + delivery_service.price).round(2)) }
      end

      context 'when order in statuses till payment' do
        let(:coupon) { 10 }
        let(:with_delivery_price) { order_without_coupon.delivery_service.price + subtotal }

        before do
          allow(subject.instance_variable_set(:@order, order_without_coupon)).to receive(:payment?).and_return(false)
          allow(subject).to receive(:coupon_order).and_return(coupon)
          allow(subject).to receive(:subtotal_order).and_return(subtotal)
        end

        context 'when coupon > subtotal' do
          let(:subtotal) { coupon - 1 }
          it { expect(subject.total_order).to eq(with_delivery_price) }
        end

        context 'when coupon < subtotal' do
          let(:subtotal) { coupon + 1 }
          it { expect(subject.total_order).to eq(with_delivery_price - coupon) }
        end
      end
    end
  end

  describe '#right_position?' do
    context 'when call right_position?' do
      let(:current_order) { create(:order) }

      before do
        allow(subject.instance_variable_set(:@order, order_without_coupon)).to receive(:payment?).and_return(false)
        order_without_coupon.update(checkout: 'confirm')
      end

      context 'when return true' do
        before do
          order_without_coupon.to_complete!
        end

        it { expect(subject.right_position?(current_order)).to eq(true) }
      end

      context 'when return false' do
        it { expect(subject.right_position?(current_order)).to eq(false) }
      end
    end
  end
end
