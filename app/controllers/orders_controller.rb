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
    @orders = Order.all.order(created_at: :desc).paginate(page: params[:page])
    @user_orders = current_user.orders.order(created_at: :desc)
      .paginate(page: params[:page])
  end

  def show
    @order_driver = User.find_by(id: @order.driver_id)
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
    if params[:status] == '0'
      flash[:warning] = I18n.t('common.you_refused_order')
    else
      flash[:notice] = I18n.t('common.you_taken_order')
    end
    redirect_back(fallback_location: root_path)
  end

  def taken_orders
    @taken_orders = Order.taken_for_driver(current_user)
      .order(date: :asc).paginate(page: params[:page])
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
