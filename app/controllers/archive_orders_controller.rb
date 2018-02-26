class ArchiveOrdersController < ApplicationController
  before_action :set_archive_order, only: %i[show destroy]
  before_action :authenticate_user!

  def create
    @order = Order.find(params[:id])
    @order.update(status: params[:status].to_i, driver_id: params[:driver_id])

    @archive_order = current_user.archive_orders.create(
      price: @order.price,
      weight: @order.weight,
      comment: @order.comment,
      status: @order.status,
      date: @order.date,
      start_point: @order.starting_point,
      destination_point: @order.destination_point
    )
    flash[:notice] = t('archive_orders.add_to_archive')
    redirect_to root_url
  end

  def index
    @archive_orders = ArchiveOrder.all.paginate(page: params[:page])
  end

  def show; end

  def destroy
    @archive_order.destroy
    flash[:alert] = t('archive_orders.delete')
    redirect_to archive_orders_path
  end

  private

  def set_archive_order
    @archive_order = ArchiveOrder.find(params[:id])
  end
end
