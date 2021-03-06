# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :counter, only: %i[delivered index taken]
  before_action :set_order, only: %i[change_status edit show update destroy]

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params).decorate

    if @order.save
      User.drivers.each do |user|
        @order.create_notification(user, current_user, t('.created'))
      end
      redirect_to @order, notice: t('orders.created')
    else
      render :new
    end
  end

  def edit; end

  def index
    @active = :index
    @orders = Order.new_order.order(created_at: :desc).paginate(page: params[:page])

    @user_orders = current_user.orders.new_order.paginate(page: params[:page])
  end

  def show; end

  def update
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path, alert: t('orders.deleted')
  end

  def archive
    @archived_orders = Order.archived_for_user(current_user)
      .paginate(page: params[:page])
  end

  def change_status
    @order.update(status: params[:status], driver_id: params[:driver_id])

    if @order.taken?
      flash[:notice] = t('common.you_take_order')
      @order.create_notification(@order.user, current_user, t('.taken'))
    elsif @order.delivered?
      flash[:warning] = t('common.add_to_archive')
      @order.create_notification(@order.user, current_user, t('.delivered'))
    else
      flash[:alert] = t('common.you_refused_order')
      @order.create_notification(@order.user, current_user, t('.refused'))
    end

    redirect_back(fallback_location: root_path)
  end

  def delivered
    @active = :delivered
    @orders = Order.delivered.paginate(page: params[:page])
  end

  def taken
    @active = :taken
    @orders = Order.taken.paginate(page: params[:page])
  end

  def taken_orders
    @taken_orders = Order.taken_by_driver(current_user).order(date: :asc)
      .paginate(page: params[:page])
  end

  private

  def counter
    @count = current_user.orders.count
  end

  def order_params
    params.require(:order).permit(:comment, :destination, :date, :price, :start, :weight)
  end

  def set_order
    @order = Order.find(params[:id]).decorate
  end
end
