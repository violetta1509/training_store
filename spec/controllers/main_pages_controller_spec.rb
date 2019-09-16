RSpec.describe MainPageController, type: :controller do
  describe '.homepage' do
    before { get :homepage }

    it 'renders the homepage template' do
      expect(subject).to render_template(:homepage)
    end

    it 'have status 200' do
      expect(response).to have_http_status(200)
    end
    context 'have valid instance variables' do
      it { expect(assigns(:new_books)).to be_kind_of(Array) }
      it { expect(assigns(:best_sellers)).to be_kind_of(Array) }
    end
  end
end
