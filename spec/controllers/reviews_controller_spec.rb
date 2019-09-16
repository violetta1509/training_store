RSpec.describe ReviewsController, type: :controller do
  describe '.create' do
    let(:user) { create(:user) }
    let(:review) { create(:review, user: user) }
    let(:book) { review.book }
    let(:title) { FFaker::Lorem.characters(10) }
    let(:body) { FFaker::Lorem.characters(50) }
    let(:score) { rand(1..5) }
    let(:params) { review.attributes.extract!('book_id', 'user_id', 'score', 'title', 'body') }

    context 'when save review' do
      before do
        login_user(user)
        post :create, params: params
      end

      it 'add review' do
        expect { post :create, params: params }.to change { Review.count }.by(1)
      end

      it 'should have success flash' do
        expect(subject.request.flash[:success]).to eq(I18n.t('review.saved_comment'))
      end

      it 'redirect to current book' do
        expect(controller).to redirect_to(book_path(book.friendly_id))
      end
    end

    context 'when can not save review' do
      before do
        params['book_id'] = nil
        login_user(user)
        post :create, params: params
      end

      it 'should have danger flash' do
        expect(subject.request.flash[:danger]).to eq(I18n.t('review.wrong_comment'))
      end

      it 'redirect to books' do
        expect(controller).to redirect_to(books_path)
      end
    end
  end
end
