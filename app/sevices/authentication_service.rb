
# frozen_string_literal: true

module AuthenticationService
  def self.from_omniauth(auth)
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name || first_name(auth)
      user.last_name = auth.info.last_name || last_name(auth)
      user.build_avatar
      user.avatar.remote_image_url = auth.info.image
    end
  end

  def self.first_name(auth)
    auth.info.name.split(' ').last
  end

  def self.last_name(auth)
    auth.info.name.split(' ').first
  end
end
