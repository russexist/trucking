# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :otp_code_token

  enum otp_module: { disabled: 0, enabled: 1 }, _prefix: true

  has_many :notifications, dependent: :destroy, foreign_key: :recipient_id
  has_many :reviews,       dependent: :destroy
  has_many :orders,        dependent: :nullify

  has_one  :avatar,        dependent: :destroy

  delegate :image, to: :avatar, allow_nil: true

  scope :drivers, -> { where(driver: true) }

  validates :email, :first_name, :last_name, presence: true

  acts_as_messageable
  has_one_time_password

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :omniauthable,
    omniauth_providers: %i[facebook google_oauth2]

  def full_name
    "#{first_name} #{last_name}"
  end

  def mailboxer_email(_object)
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
end
