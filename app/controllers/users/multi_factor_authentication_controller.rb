# frozen_string_literal: true

class Users::MultiFactorAuthenticationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def verify_enable
    if current_user == @user &&
       current_user.authenticate_otp(
         params[:multi_factor_authentication][:otp_code_token], drift: 60
       )
      current_user.otp_module_enabled!
      redirect_to edit_user_registration_path, notice: t('tfa.enabled')
    else
      redirect_to edit_user_registration_path, alert: t('tfa.not_be_enabled')
    end
  end

  def verify_disabled
    if current_user == @user &&
       current_user.authenticate_otp(
         params[:multi_factor_authentication][:otp_code_token], drift: 60
       )
      current_user.otp_module_disabled!
      redirect_to edit_user_registration_path, notice: t('tfa.disabled')
    else
      redirect_to edit_user_registration_path, alert: t('tfa.not_be_disabled')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
