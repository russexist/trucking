# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  helper_method :mailbox, :conversation

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def profile
    @user = User.find_by(id: params[:id]) || current_user
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:avatar, :current_password, :driver, :email,
        :first_name, :last_name, :password, :password_confirmation, :phone,
        :remember_me)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:avatar, :current_password, :driver, :email,
        :first_name, :last_name, :password, :password_confirmation, :phone)
    end
  end
end
