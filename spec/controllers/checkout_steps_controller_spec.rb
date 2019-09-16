require 'rails_helper'

RSpec.describe CheckoutStepsController, type: :controller do
  describe '#show' do
    subject{ get :show }

    context 'when user has not account' do
      before { subject }
      it 'register template' do
        expect(subject).to render_template(:quick_registration)
      end

    end

    context 'when user sign in' do
      let!(:user) { create(:user, :with_order) }
      let(:order) { user.orders.first }

      before { login_user(user) }

      it 'render address template' do
        subject
        expect(assigns(:presenter)).to be_kind_of(AddressPresenter)
        expect(subject).to render_template(:address)
      end

      it 'render delivery template' do
        user.orders.first.to_delivery!
        subject
        expect(assigns(:presenter)).to be_kind_of(DeliveryPresenter)
        expect(subject).to render_template(:delivery)
      end

      it 'render payment template' do
        order.update(checkout: CheckoutStepService::VIEW_STEPS[:payment])
        subject
        expect(assigns(:presenter)).to be_kind_of(PaymentPresenter)
        expect(subject).to render_template(:payment)
      end

      it 'render confirm template' do
        order.update(checkout: CheckoutStepService::VIEW_STEPS[:confirm])
        subject
        expect(assigns(:presenter)).to be_kind_of(ConfirmPresenter)
        expect(subject).to render_template(:confirm)
      end

      it 'render complete template' do
        order.update(checkout: CheckoutStepService::VIEW_STEPS[:complete])
        subject
        expect(assigns(:presenter)).to be_kind_of(CompletePresenter)
        expect(subject).to render_template(:complete)
      end
    end
  end

  describe '#update' do
    let!(:user) { create(:user, :with_order) }
    let(:order) { user.orders.first }

    subject{ patch :update, params: params }

    before { login_user(user) }

    context 'when address step' do
      let(:user_billing_address) { create(:user_billing_address, addressable: user)}
      let(:order_billing_address) { create(:order_billing_address, addressable: user.orders.first)}
      let(:order_shipping_address) { create(:order_shipping_address, addressable: user.orders.first)}
      let(:billing_address) { FactoryBot.attributes_for(:order_billing_address, type: 'billing_address') }
      let(:shipping_address) { FactoryBot.attributes_for(:order_shipping_address, type: 'shipping_address') }
      let(:incorrect_shipping_address) { Address.new.attributes }
      let(:incorrect_billing_address) { Address.new.attributes }

      before do
        incorrect_billing_address['type'] = 'billing_address'
        incorrect_shipping_address['type'] = 'shipping_address'
      end

      context 'when render first step template' do
        subject { get :show }

        it 'address template' do
          expect(subject).to render_template(:address)
        end
      end

      context 'when fill correct data' do
        let(:params) { order_params }

        context 'when filling billing and shipping address' do
          let(:order_params) { { order: { billing_address: billing_address,
                                          shipping_address: shipping_address } } }

            it 'assign order billing&shipping address' do
              subject
              expect(user.orders.first.billing_address).to_not be_nil
              expect(user.orders.first.shipping_address).to_not be_nil
            end
          end

          context 'when use billing like shipping address' do
            let(:order_params) { { order: { billing_address: billing_address,
                                            shipping_address: incorrect_shipping_address,
                                            use_billing: 'true'} } }

              it 'assign order shipping address with use billing address' do
                subject
                expect(user.orders.first.billing_address).to_not be_nil
                expect(user.orders.first.shipping_address).to_not be_nil
              end
            end
          end

      context 'when fill incorrect data address' do
        let(:incorrect_shipping_params) { { order: { billing_address: billing_address,
                                                     shipping_address: incorrect_shipping_address } } }
        let(:incorrect_billing_params) { { order: { billing_address: incorrect_billing_address,
                                                    shipping_address: shipping_address } } }

        context 'when fill shipping address' do
          let(:params) { incorrect_billing_params }

          it 'not assign order billing address' do
            subject
            expect(user.orders.first.billing_address).to be_nil
            expect(user.orders.first.shipping_address).to_not be_nil
          end

          it 'render address template with billing errors' do
            subject
            expect(assigns(:presenter)).to be_kind_of(AddressPresenter)
            expect(subject).to render_template(:address)
          end

          it 'render address template with billing errors' do
            subject

            expect(assigns(:presenter).billing_address.errors.empty?).to eq(false)
          end
        end

        context 'when fill billing address' do
          let(:params) { incorrect_shipping_params }

          it 'not assign order shipping address' do
            subject
            expect(user.orders.first.billing_address).to_not be_nil
            expect(user.orders.first.shipping_address).to be_nil
          end

          it 'render address template with instance and address template' do
            subject
            expect(assigns(:presenter)).to be_kind_of(AddressPresenter)
            expect(subject).to render_template(:address)
          end

          it 'render address template with shipping errors' do
            subject

            expect(assigns(:presenter).shipping_address.errors.empty?).to eq(false)
          end
        end
      end
    end

    context 'when delivery step' do
      let!(:delivery_service) { create(:delivery_service) }
      let(:params) { { delivery: { deliver_id: delivery_service.id } } }

      before do
        order.to_delivery!
      end

      it 'assign delivery service to order' do
        subject
        expect(user.orders.first.delivery_service_id).to eq(delivery_service.id)
      end
    end

    context 'when payment step' do
      before do
        order.update(checkout: 'payment')
      end

      context 'when correct credit_card' do
        let(:card) { create(:credit_card) }
        let(:params) { { credit_card: FactoryBot.attributes_for(:credit_card) } }

        it 'assign delivery credit_card to order' do
          expect(user.orders.first.credit_card).to be_nil

          subject
          expect(user.orders.first.credit_card).to_not be_nil
        end

        it 'redirect to show' do
          subject
          expect(subject).to redirect_to(checkout_step_path)
        end
      end

      context 'when incorrent credit_card' do
        let(:params) { { credit_card: CreditCard.new.attributes } }

        it 'try assign incorrect credit_card' do
          expect(user.orders.first.credit_card).to be_nil
          subject
          expect(user.orders.first.credit_card).to be_nil
        end

        it 'payment template' do
          subject
          expect(assigns(:presenter)).to be_kind_of(PaymentPresenter)
          expect(subject).to render_template(:payment)
        end
      end
    end

    context 'when confirm step' do
      let(:params) {}
      before do
        order.update(checkout: 'confirm')
      end

      it 'redirect to show' do
        expect(subject).to redirect_to(checkout_step_path)
      end

      it 'order to complete' do
        subject
        expect(user.orders.first.complete?).to eq(true)
      end
    end
  end
end
