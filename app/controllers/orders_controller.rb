# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, except: %i[new index create taken_orders]
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
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
    @taken_orders = Order.taken_for_driver(current_user).paginate(page: params[:page])
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:comment, :destination, :date, :price, :start, :weight)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
