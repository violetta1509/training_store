require 'pry'
class ReviewsController < ApplicationController
  def create
    @review = AddReviewService.new(permit_params).call
    @review.save ? flash[:success] = 'yra' : flash[:danger] = 'bad'

    redirect_to book_path(params[:book_id])
  end

  def permit_params
    params.permit(:user_id, :book_id, :title, :body, :score)
  end
end
