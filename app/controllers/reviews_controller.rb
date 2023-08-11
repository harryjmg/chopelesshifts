class ReviewsController < ApplicationController
  def create_review
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to root_path, notice: 'Merci pour votre avis!'
    else
      flash[:alert] = 'Il y a eu un problème lors de la sauvegarde de votre avis'
    end
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
