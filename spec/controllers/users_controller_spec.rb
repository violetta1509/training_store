require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before { login_user }

  subject(:controller_action) { patch 'update', params: params }

  describe '.update_email' do
    context 'when correct email' do
      let(:email) { 'correct@email.com' }
      let(:params) { { email_form: { email: email } } }

      context 'when correct email' do

        before { controller_action }

        it 'alert update of email' do
          expect(flash[:notice]).to eq(I18n.t('settings.updated_email'))
        end

        it 'redirect to settings' do
          expect(controller).to redirect_to(settings_path)
        end
      end

      context 'when update email' do
        it 'update email in db' do
          expect { controller_action }.to change { controller.current_user.email }
        end
      end
    end

    context 'when incorrect email' do
      let(:email) { '@.com' }
      let(:params) { { email_form: { email: email } } }

      context 'when wrong email' do
        before { controller_action }

        it 'alert danger update of email' do
          expect(flash[:notice]).to eq(I18n.t('settings.mistake_update_email'))
        end

        it 'redirect to settings' do
          expect(controller).to redirect_to(settings_path)
        end
      end

      context 'when update email' do
        it 'does not update email in db' do
          expect { controller_action }.to_not change { controller.current_user }
        end
      end
    end
  end

  describe '.update_password' do
    let(:params) do
      { password_form: {
        current_password: current_password,
        password: password,
        password_confirmation: password
      } }
    end


    context 'when passwords dose\`t match' do
      before do
        allow_any_instance_of(UpdateUserService).to receive(:call).and_return(false)

        subject
      end

      let(:current_password) { 'dosenotma4' }
      let(:password) { 'Faker121word' }

      context 'when incorrect password' do
        it 'alert can\`t update of password' do
          expect(flash[:notice]).to eq(I18n.t('settings.mistake_update_password'))
        end

        it 'redirect to settings' do
          expect(controller).to redirect_to(settings_path)
        end
      end
    end

    context 'when passwords match' do
      let(:password) { 'Dosenotma4' }
      let(:current_password) { 'Faker121word' }

      before do
        allow_any_instance_of(UpdateUserService).to receive(:call).and_return(true)
        subject
      end

      context 'when correct password' do
        it 'redirect to settings' do
          expect(controller).to redirect_to(settings_path)
        end

        it 'alert updated of password' do
          expect(flash[:notice]).to eq(I18n.t('settings.updated_password'))
        end
      end
    end
  end

  describe '.update_billing' do
    let!(:user) { create(:user) }
    let(:params) { { billing_address: attributes_for(:user_billing_address, :correct_address) } }

    context 'when update billing_address' do
      before do
        user.build_billing_address
      end

      it 'update billing attributes' do
        expect { subject }.to change { controller.current_user.billing_address }
      end

      it 'redirect to settings' do
        expect(subject).to redirect_to(settings_path)
      end
    end
  end

  describe '.update_shipping' do
    let(:params) { { shipping_address: attributes_for(:user_shipping_address, :correct_address) } }

    context 'when update shipping_address' do
      before do
        user.build_shipping_address
      end

      it 'redirect to settings' do
        expect(subject).to redirect_to(settings_path)
      end

      it 'update billing attributes ' do
        expect { subject }.to change { controller.current_user.shipping_address }
      end
    end
  end
end
