# frozen_string_literal: true

class StartsController < ApplicationController
  before_action :set_starting_point, except: %i[new create]
  before_action :authenticate_user!

  def new
    @starting_point = Start.new
  end

  def create
    @starting_point = current_user.starts.new(starting_point_params)
    if @starting_point.save
      flash[:notice] = t('starts.create')
      redirect_to new_destination_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @starting_point.update(starting_point_params)
      redirect_to order_path(@starting_point.order)
    else
      render 'edit'
    end
  end

  def destroy
    @starting_point.destination.destroy
    @starting_point.destroy
    flash[:alert] = t('orders.delete')
    redirect_to orders_path
  end

  private

  def starting_point_params
    params.require(:start).permit(:start_latitude, :start_longitude, :starting_point)
  end

  def set_starting_point
    @starting_point = Start.find(params[:id])
  end
end
