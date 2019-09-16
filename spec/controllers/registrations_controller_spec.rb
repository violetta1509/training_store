RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#create' do
    let(:password) { SecureRandom.base64(10) }
    let(:params) { { user: FactoryBot.attributes_for(:user,
                                                       email: email,
                                                       password: password,
                                                       password_confirmation: password,
                                                       quick: 'true') } }

    subject { post :create, params: params }

    before { @request.env['devise.mapping'] = Devise.mappings[:user] }

    context 'correct email' do
      let(:email) { FFaker::Internet.email }

      it 'redirect to root path' do
        subject
        expect(controller).to redirect_to(checkout_step_path)
      end

      it 'create a user' do
        expect { subject }.to change { User.all.count }.by(1)
      end
    end

    context 'incorrect email' do
      let(:email) { '@.com' }

      it 'redirect with notice' do
        subject
        expect(flash[:notice]).to eq(I18n.t('registrations.can_not_use_account'))
        expect(controller).to redirect_to(checkout_step_path)
      end

      it 'create a user' do
        expect { subject }.to_not change { User.all.count }
      end
    end

    describe '#delete_account' do
      let!(:another_user) { create(:user) }
      let!(:user) { create(:user) }
      subject { delete 'destroy', params: params }

      before do
        login_user(user)
      end

      context 'when delete self account' do
        let(:params) { { resource: user } }

        it { expect{ subject }.to change { User.count }.from(2).to(1) }
      end

      context 'when try delete another account' do
        let(:params) { { resource: another_user } }

        before { subject }

        it { expect(User.first.id).to eq(another_user.id) }
      end
    end
  end
end
