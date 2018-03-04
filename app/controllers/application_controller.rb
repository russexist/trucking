# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def profile
    @user = params[:id] ? User.find_by(id: params[:id]) : current_user
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password,
        :password_confirmation, :remember_me, :first_name,
        :last_name, :phone, :driver)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password,
        :password_confirmation, :current_password,
        :first_name, :last_name, :phone, :driver)
    end
  end
end
