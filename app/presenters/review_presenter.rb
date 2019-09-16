class ReviewPresenter
  def display_email(user, review)
    review.verified ? (user.email + I18n.t('review.verified')) : user.email
  end
end
