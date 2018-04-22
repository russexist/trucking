# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    driver = User.find(params[:user_id])
    @review = current_user.reviews.build(review_params.merge(driver: driver))

    if @review.save
      flash[:notice] = t('reviews.create')
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = t('rebiews.error')
      redirect_back(fallback_location: root_path)
    end
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
