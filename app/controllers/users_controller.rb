# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = Review.all.paginate(page: params[:page])
  end
end
