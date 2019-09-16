describe ShortAddressPresenter do
  let!(:order) { create(:order) }
  let!(:order_billing_address) { create(:order_billing_address, addressable: order) }
  let!(:order_shipping_address) { create(:order_shipping_address, addressable: order) }

  before do
    allow(subject.instance_variable_set(:@order, order))
  end

  describe '#full_address' do
    context 'when show full shipping and billing address' do
      it { expect(subject.full_address('billing_address')).to eq("#{order.billing_address.first_name} #{order.billing_address.last_name}") }
      it { expect(subject.full_address('shipping_address')).to eq("#{order.shipping_address.first_name} #{order.shipping_address.last_name}") }
    end
  end

  describe '#address' do
    it { expect(subject.address('billing_address')).to eq(order.billing_address.address) }
    it { expect(subject.address('shipping_address')).to eq(order.shipping_address.address) }
  end

  describe '#country' do
    it { expect(subject.country('billing_address')).to eq("#{order.billing_address.country} #{order.billing_address.zip}") }
    it { expect(subject.country('shipping_address')).to eq("#{order.shipping_address.country} #{order.shipping_address.zip}") }
  end

  describe '#city' do
    it { expect(subject.city('billing_address')).to eq(order.billing_address.city) }
    it { expect(subject.city('shipping_address')).to eq(order.shipping_address.city) }
  end

  describe '#order_items' do
    it { expect(subject.order_items).to eq(order.order_items) }
  end

  describe '#phone' do
    it { expect(subject.phone('billing_address')).to eq(order.billing_address.phone) }
    it { expect(subject.phone('shipping_address')).to eq(order.shipping_address.phone) }
  end
end
