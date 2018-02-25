# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, except: %i[new index create taken_orders]
  before_action :set_points, only: :create
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params.merge(
      start_id: @start.id,
      destination_id: @destination.id
    ))
    if @order.save
      flash[:notice] = t('orders.create')
      redirect_to @order
    else
      render 'new'
    end
  end

  def edit; end

  def index
    @orders = Order.all.paginate(page: params[:page])
    @user_orders = current_user.orders.paginate(page: params[:page])
  end

  def show
    @driver = User.find_by(id: @order.driver_id)
  end

  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  def change_status
    @order.update(status: params[:status].to_i, driver_id: params[:driver_id])
    redirect_to taken_orders_path
  end

  def taken_orders
    @taken_orders = Order.where(status: 1, driver_id: current_user)
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:comment, :date, :price, :weight)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_points
    @start = current_user.starts.last
    @destination = current_user.destinations.last
  end
end
