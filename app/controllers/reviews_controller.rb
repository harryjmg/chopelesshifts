class ReviewsController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to root_path, notice: 'Merci pour ton avis, ça fait plaisir !'
    else
      respond_to do |format|
        format.turbo_stream { render template: 'shared/create_review' }
        format.html { render :new }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
