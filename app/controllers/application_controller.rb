# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def profile
    @user = params[:driver] ? User.find_by(id: params[:driver]) : current_user
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
