require 'rails_helper'

RSpec.describe MainPageController, type: :controller do
  describe 'homepage action' do
    before do
      get :homepage
    end

    it { expect(response).to have_http_status(200) }
    it { expect(assigns(:best_sellers)) }
    it { expect(assigns(:new_books)) }
    it { expect(assigns(:book_presenter)) }
    it { expect(assigns(:header)) }
  end
end
