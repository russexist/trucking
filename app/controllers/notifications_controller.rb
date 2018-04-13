# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :set_notifications, except: :destroy

  def index
    @notifications = Notification.for_user(current_user).paginate(page: params[:page])
  end

  def destroy
    Notification.find(params[:id]).destroy
    redirect_to notifications_path
  end

  def mark_as_read
    @uread_notifications.update_all(read_at: Time.current)
    render json: { sucess: true }
  end

  private

  def set_notifications
    @uread_notifications = Notification.for_user(current_user).unread
  end
end
