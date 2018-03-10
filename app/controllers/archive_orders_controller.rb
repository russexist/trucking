# frozen_string_literal: true

class ArchiveOrdersController < ApplicationController
  before_action :set_archive_order, only: %i[show destroy]
  before_action :set_order, only: :create
  before_action :authenticate_user!

  def create
    @order.update(status: params[:status].to_i, driver_id: params[:driver_id])
    @archive_order = current_user.archive_orders.create(archive_order_params)
    flash[:notice] = t('archive_orders.add_to_archive')
    redirect_to root_url
  end

  def index
    @archive_orders = current_user.archive_orders.paginate(page: params[:page])
  end

  def show; end

  def destroy
    @archive_order.destroy
    flash[:alert] = t('archive_orders.delete')
    redirect_to archive_orders_path
  end

  private

  def archive_order_params
    {
      price: @order.price,
      weight: @order.weight,
      comment: @order.comment,
      status: 2,
      date: @order.date,
      start_point: @order.start,
      destination_point: @order.destination
    }
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_archive_order
    @archive_order = ArchiveOrder.find(params[:id])
  end
end
