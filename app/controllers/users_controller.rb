class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = Review.all
  end
end
