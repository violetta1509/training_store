RSpec.describe BooksController, type: :controller do
  describe '.index' do
    before { get :index }

    it 'renders the homepage template' do
      expect(subject).to render_template(:index)
    end

    it 'have status 200' do
      expect(response).to have_http_status(200)
    end

    context 'have valid instance variables' do
      it { expect(assigns(:books)).to be_kind_of(ActiveRecord::Relation) }
      it { expect(assigns(:current_filter)).to be_kind_of(String) }
    end
  end

  describe '.show' do

    context 'when correct book id' do
      before { get :show, params: { id: book_id } }

      let(:book_id) { create(:book).friendly_id }

      it 'renders the show template' do
        expect(subject).to render_template(:show)
      end

      it 'have status 200' do
        expect(response).to have_http_status(200)
      end

      it 'have valid instance' do
        expect(assigns(:book)).to be_kind_of(Book)
      end
    end

    context 'when unknown book id' do
      let(:book_id) { 'unknown' }

      it 'have a RecordNotFound error' do
        expect{ get :show, params: { id: book_id } }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
