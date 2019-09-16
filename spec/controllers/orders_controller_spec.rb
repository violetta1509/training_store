RSpec.describe OrdersController, typr: :controller do

  describe '#index' do
    let!(:user) { create(:user, :with_order) }
    let!(:params) { { filter: 'In progress' } }

    before do
      login_user(user)
    end

    it 'presenter' do
      get :index, params: params
      expect(assigns(:presenter)).to be_kind_of(OrderPresenter)
      expect(controller).to render_template(:index)
    end
  end
end
