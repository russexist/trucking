class OrdersController < ApplicationController
  before_action :get_order, except: [:new, :index, :create]
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      flash[:notice] = "Order was succesfully created"
      redirect_to @order
    else
      render 'new'
    end
  end

  def edit; end

  def index
    @orders = Order.all
  end

  def show; end

  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  def change_status
    @order.update(status: params[:status].to_i)
    redirect_to orders_path
  end

  def destroy
    @order.destroy
    flash[:alert] = "Order was succesfully deleted"
    redirect_to orders_path
  end

  private
    def order_params
      params.require(:order).permit(:start_point, :finish_point, :price, :weight, :comment, :status)
    end

    def get_order
      @order = Order.find(params[:id])
    end
end
