class ReviewPresenter < ApplicationPresenter
  def initialize(user_id)
    @user_id = user_id
  end

  def take_user
    User.find_by(id: @user_id)
  end
  # Don't worry about the initialize method, it's already handled for you.

    # You can now pass in an instance of Review when you initialize this presenter
    # and access it with the helper method: subject

    # Write methods for this presenter in here using the helper method
end
