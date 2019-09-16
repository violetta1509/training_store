module LoginUser
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin)
    end
  end

  def login_user(current_user = nil)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = current_user || create(:user)
    sign_in user
  end
end
