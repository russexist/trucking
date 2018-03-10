# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def profile
    @user = User.find_by(id: params[:id]) || current_user
  end

  def delete_avatar
    current_user.remove_avatar!
    current_user.save
    redirect_back(fallback_location: root_path)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
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
