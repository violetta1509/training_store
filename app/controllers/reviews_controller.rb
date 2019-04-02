class ReviewsController < ApplicationController
  def create
    make_review = Review.create(book_id: review_params[:book_id],
                                user_id: review_params[:user_id],
                                score: review_params[:score],
                                title: review_params[:title],
                                body: review_params[:body])
    make_review.save ? flash[:success] = t(:'review.saved_comment') : flash[:danger] = t(:'review.wrong_comment')

    redirect_to book_path(params[:book_id])
  end

  def review_params
    params.permit(:user_id, :book_id, :title, :body, :score)
  end
end
