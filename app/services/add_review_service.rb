class AddReviewService
  def initialize(params)
    @params = params
  end

  def call
    Review.create(book_id: @params[:book_id],
                  user_id: @params[:user_id],
                  score: @params[:score],
                  title: @params[:title],
                  body: @params[:body])
  end
end
