class ReviewsController < ApplicationController
  def create_review
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to videos_path, notice: 'Merci pour votre avis!'
    else
      # TODO: handle error
      puts "Failled to save review"
      puts @review.errors.full_messages
    end
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
