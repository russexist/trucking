# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authenticate('Facebook')
  end

  def google_oauth2
    authenticate('Google')
  end

  private

  def authenticate(kind)
    @user = AuthenticationService.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      redirect_to new_user_session_path, alert: t('common.omniauth.error')
    end
  end
end
