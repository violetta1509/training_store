RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe '.facebook' do
    before do
      OmniAuth.config.test_mode = true
    end

    context 'when user persisted' do
      before do
        OmniAuth.config.mock_auth[:facebook] = authhash('pupkin@gmail.com')
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
      end

      it 'have status 200' do
        expect(response).to have_http_status(200)
      end

      it 'add user' do
        expect { post :facebook }.to change { User.count }.by(1)
      end

      it 'does not set a flash' do
        post :facebook
        expect(flash[:alert]).to_not be_present
      end
    end
    context 'when user is not persisted' do
      before do
        OmniAuth.config.mock_auth[:facebook] = authhash(nil)
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
        post :facebook
      end

      it 'redirect to new_user_registration_url' do
        expect(controller).to redirect_to(new_user_registration_url)
      end
    end
  end
end
