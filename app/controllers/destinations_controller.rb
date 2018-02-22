# frozen_string_literal: true

class DestinationsController < ApplicationController
  before_action :destination_point, except: %i[new create]
  before_action :authenticate_user!

  def new
    @destination_point = Destination.new
  end

  def create
    @destination_point = current_user.destinations.new(destination_point_params)
    if @destination_point.save
      flash[:notice] = t('destinations.create')
      redirect_to new_order_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @destination_point.update(destination_point_params)
      redirect_to order_path(@destination_point.order)
    else
      render 'edit'
    end
  end

  private

  def destination_point_params
    params.require(:destination).permit(
      :destination_latitude,
      :destination_longitude,
      :destination_point
    )
  end

  def destination_point
    @destination_point = Destination.find(params[:id])
  end
end
