# frozen_string_literal: true

module AuthorizationHelper
  def sign_in(user)
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password

    click_button I18n.t('devise.sessions.new.sign_in')
  end
end
