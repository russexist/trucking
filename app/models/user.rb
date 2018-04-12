# frozen_string_literal: true

class User < ApplicationRecord
  has_many :notifications, dependent: :destroy, foreign_key: :recipient_id
  has_many :reviews,       dependent: :destroy
  has_many :orders,        dependent: :nullify
  has_one  :avatar,        dependent: :destroy

  delegate :image, to: :avatar, allow_nil: true

  scope :drivers, -> { where(driver: true) }

  validates :email, :first_name, :last_name, presence: true

  acts_as_messageable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :omniauthable,
    omniauth_providers: %i[facebook google_oauth2]

  def full_name
    "#{first_name} #{last_name}"
  end

  def mailboxer_email(_oject)
    email
  end

  def mailboxer_name
    name
  end

  def not_driver?
    driver.blank?
  end

  def photo?
    avatar.present?
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
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
