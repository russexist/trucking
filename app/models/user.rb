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
  end #decorator

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
