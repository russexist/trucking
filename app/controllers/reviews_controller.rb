# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    driver = User.find(params[:user_id])
    @review = current_user.reviews.create(review_params.merge(driver: driver))
    flash[:notice] = t('reviews.create')
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:alert] = t('reviews.destroy')
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
