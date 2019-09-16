require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  describe '.update' do

    subject{ patch :update, params: params }

    context 'when guest have correct coupon' do
      let(:coupon) { create(:coupon, :enabled_coupon, order: nil) }
      let(:params) {{ discount: {key: coupon.key, value: coupon.value} }}

      before { subject }

      it 'save to session' do
        expect(controller.session[:coupon]).to eq(coupon.id)
      end

      it 'alert apply coupon' do
        expect(flash[:danger]).to eq(I18n.t('cart.disabled_coupon'))
      end

      it 'redirect to cart' do
        expect(controller).to redirect_to(cart_path)
      end
    end

    context 'when guest have incorrect coupon' do
      let(:coupon) { create(:coupon, :disabled_coupon, order: nil) }
      let(:params) {{ discount: {key: coupon.key, value: coupon.value} }}

      before do
        subject
      end

      it 'save to session' do
        expect(controller.session[:coupon]).to be_nil
      end

      it 'alert apply coupon' do
        expect(flash[:danger]).to eq(I18n.t('cart.disabled_coupon'))
      end

      it 'redirect to cart' do
        expect(controller).to redirect_to(cart_path)
      end
    end

    context 'when user have correct coupon' do
      let(:user) { create(:user, :with_order) }
      let(:params) {{ discount: {key: coupon.key, value: coupon.value} }}
      context 'when order total more then coupon' do
        let(:coupon) { create(:coupon, :enabled_coupon, :value_less_order, order: nil) }


        context 'when change order' do
          before do
            login_user(user)
          end
          it { expect{ subject }.to change {controller.current_order.coupon_id}.from(nil).to(coupon.id) }
        end

        context 'when change order total common' do
          before do
            login_user(user)
            subject
          end

          it 'alert apply coupon' do
            expect(flash[:notice]).to eq(I18n.t('cart.eneble_coupon'))
          end

          it 'redirect to cart' do
            expect(controller).to redirect_to(cart_path)
          end
        end
      end

      context 'when order total less then coupon' do

        let(:coupon) { create(:coupon, :enabled_coupon, order: nil) }

        before do
          login_user(user)
          subject
        end

        it 'alert apply coupon' do
          expect(flash[:danger]).to eq(I18n.t('cart.disabled_coupon'))
        end

        it 'redirect to cart' do
          expect(controller).to redirect_to(cart_path)
        end
      end
    end

    context 'when user have incorrect coupon' do
      let(:user) { create(:user, :with_order) }
      let(:params) {{ discount: {key: coupon.key, value: coupon.value} }}
      context 'when order total more then coupon' do
        let(:coupon) { create(:coupon, :disabled_coupon, :value_less_order, order: nil) }


        context 'when dose not change order' do
          before do
            login_user(user)
          end
          it { expect{ subject }.to_not change {controller.current_order.coupon_id} }
        end

        context 'when change order total common' do
          before do
            login_user(user)
            subject
          end

          it 'alert apply coupon' do
            expect(flash[:danger]).to eq(I18n.t('cart.disabled_coupon'))
          end

          it 'redirect to cart' do
            expect(controller).to redirect_to(cart_path)
          end
        end
      end

      context 'when order total less then coupon' do

        let(:coupon) { create(:coupon, :enabled_coupon, order: nil) }

        before do
          login_user(user)
          subject
        end

        it 'alert apply coupon' do
          expect(flash[:danger]).to eq(I18n.t('cart.disabled_coupon'))
        end

        it 'redirect to cart' do
          expect(controller).to redirect_to(cart_path)
        end
      end
    end
  end
end
