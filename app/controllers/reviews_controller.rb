class ReviewsController < ApplicationController
  authorize_resource

  def create
    review = Review.new(review_params)
    review.verified = true if verified_user?
    if review.save
      flash[:success] = t('review.saved_comment')
      redirect_to book_path(review.book.friendly_id)
    else
      flash[:danger] = t('review.wrong_comment')
      redirect_to books_path
    end
  end

  private

  def verified_user?
    OrderItem.joins(:order).where(orders: { user_id: current_user.id, checkout: CheckoutStepService::VIEW_STEPS[:complete] },
                                  order_items: { book_id: review_params[:book_id] }).present?
  end

  def review_params
    params.permit(:user_id, :book_id, :title, :body, :score)
  end
end
