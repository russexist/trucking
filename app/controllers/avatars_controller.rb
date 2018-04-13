# frozen_string_literal: true

class AvatarsController < ApplicationController
  before_action :set_avatar, except: %i[create new]

  def new
    @avatar = Avatar.new
  end

  def create
    @avatar = current_user.build_avatar(avatar_params)

    if @avatar.save
      crop_image
    else
      render :new
    end
  end

  def edit; end

  def update
    if @avatar.update(avatar_params)
      crop_image
    else
      render :edit
    end
  end

  def destroy
    @avatar.destroy
    redirect_back(fallback_location: root_path)
  end

  def crop_image
    if params[:avatar][:image].present?
      render :crop
    else
      redirect_to user_path(current_user)
    end
  end

  private

  def avatar_params
    params.require(:avatar).permit(:image, :crop_x, :crop_y, :crop_w, :crop_h)
  end

  def set_avatar
    @avatar = Avatar.find(params[:id])
  end
end
