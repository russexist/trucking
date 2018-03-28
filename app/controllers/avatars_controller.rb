# frozen_string_literal: true

class AvatarsController < ApplicationController
  before_action :set_avatar, except: %i[new create]
  before_action :authenticate_user!

  def new
    @avatar = Avatar.new
  end

  def create
    @avatar = Avatar.new(avatar_params.merge(user: current_user))

    if @avatar.save
      if params[:avatar][:image].present?
        render 'crop'
      else
        redirect_to profile_path
      end
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @avatar.update(avatar_params)
      if params[:avatar][:image].present?
        render 'crop'
      else
        redirect_to profile_path
      end
    else
      render 'edit'
    end
  end

  def destroy
    @avatar.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def avatar_params
    params.require(:avatar).permit(:image, :crop_x, :crop_y, :crop_w, :crop_h)
  end

  def set_avatar
    @avatar = Avatar.find(params[:id])
  end
end
