RSpec.describe OrderItemsController, type: :controller do
  let(:book_id) { '1' }
  let(:quantity) { '1' }

  describe '.update' do
    let(:params) { { book_id: book_id, value: quantity } }

    subject{ patch :update, params: params }

    context 'when user is guest' do
      before do
        controller.session[:guest_items] = {}
        subject
      end

      it 'redirect to' do
        expect(subject).to redirect_to cart_path
      end

      it 'add item to session' do
        expect(controller.session[:guest_items]).to eq({ book_id => quantity })
      end

      it 'have status 302' do
        expect(response).to have_http_status(302)
      end
    end

    context 'when user' do
      let!(:user) { create(:user, :with_order) }
      let(:item) { user.orders.in_progress.first.order_items.first }
      let(:number) { item.quantity }
      let(:quantity) { item.quantity + 1 }
      let(:book_id) { item.book_id }

      context 'when update item' do
        before { login_user(user) }

        it 'update item quantity' do
          expect { subject }.to change { OrderItem.find_by(book_id: book_id).quantity }.by(1)
        end
      end

      context 'when common behavior page' do
        before do
          login_user(user)
          subject
        end

        it 'redirect to' do
          expect(subject).to redirect_to cart_path
        end

        it 'have status 302' do
          expect(response).to have_http_status(302)
        end
      end
    end
  end

  describe '.destroy' do

    subject{ delete :destroy, params: params }

    context 'when user is guest' do
      let(:params) { { id: book_id } }

      before do
        controller.session[:guest_items] = {book_id => quantity}
        subject
      end

      it 'redirect to' do
        expect(subject).to redirect_to cart_path
      end

      it 'add item to session' do
        expect(controller.session[:guest_items][book_id]).to eq(nil)
      end
    end

    context 'when user' do
      let!(:user) { create(:user, :with_order) }
      let(:item) { user.orders.in_progress.first.order_items.first }
      let(:book_id) { item.book_id }
      let(:params) { { id: book_id } }

      context 'when destroy item' do
        before { login_user(user) }

        it 'update item quantity' do
          expect { subject }.to change { OrderItem.find_by(book_id: book_id) }.to eq(nil)
        end

      end
      context 'when common behavior page' do
        before do
          login_user(user)
          subject
        end

        it 'redirect to' do
          expect(subject).to redirect_to cart_path
        end

        it 'have status 302' do
          expect(response).to have_http_status(302)
        end
      end
    end
  end

  describe '.create' do
    let(:order_item) { create(:order_item) }
    let(:params) { { book_id: order_item.id, quantity: quantity } }

    subject { post :create, params: params }

    context 'when guest update item' do
      before { controller.session[:guest_items] = {order_item.id.to_s => '1'} }

      it 'add items to session' do
        expect{subject}.to change {controller.session[:guest_items][order_item.id.to_s]}.from('1').to('2')
      end
    end

    context 'when user is guest' do

      before { subject }

      it 'when redirect to' do
        expect(subject).to redirect_to books_path
      end

      it 'have status 302' do
        expect(response).to have_http_status(302)
      end

      it 'add items to session' do
        expect(controller.session[:guest_items]).to eq({ order_item.id.to_s => quantity })
      end
    end

    context 'when user login' do
      subject(:subject) { post :create, params: params }
      let(:book) { create(:book) }
      let(:params) { { book_id: book.id.to_s, quantity: '1' } }
      let(:user) { create(:user, :with_order) }

      before do
        login_user(user)
        subject
      end

      it 'should have a current_user' do
        expect(controller.current_user).to_not eq(nil)
      end

      it 'should add order item' do
        expect(OrderItem.all.any?).to_not eq(false)
      end

      it 'should have success flash' do
        expect(subject.request.flash[:success]).to_not be_nil
      end
    end
  end
end
