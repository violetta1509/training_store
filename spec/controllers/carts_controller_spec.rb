require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe '.show' do
    before do
      controller.session[:guest_items] = {'1' => '1'}
      get :show
    end
    
    context 'when guest' do

      it { expect(assigns(:items)).to be_kind_of(Hash) }

      it 'have status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders the show template' do
        expect(subject).to render_template(:show)
      end
    end

    context 'when user' do
      let!(:user) { create(:user, :with_order) }

      before do
        login_user(user)
      end

      it { expect(assigns(:items)).to be_kind_of(Hash) }

      it 'have status 200' do
        expect(response).to have_http_status(200)
      end

      it 'renders the show template' do
        expect(subject).to render_template(:show)
      end
    end
  end
end
