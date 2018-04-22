# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)

    if resource&.otp_module_disabled?
      continue_sign_in(resource, resource_name)

    elsif resource&.otp_module_enabled?

      if params[:user][:otp_code_token].size.positive?
        authenticate_otp
      else
        sign_out resource
        redirect_to root_url, alert: t('tfa.needs_token')
      end

    end
  end

  def authenticate_otp
    if resource.authenticate_otp(params[:user][:otp_code_token], drift: 60)
      continue_sign_in(resource, resource_name)
    else
      sign_out resource
      redirect_to root_url, alert: t('tfa.bad_credential')
    end
  end

  private

  def continue_sign_in(resource, resource_name)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
