class ReviewPresenter < ApplicationPresenter
  def take_user
    User.find_by(id: subject)
  end
end
