# frozen_string_literal: true

class User < ApplicationRecord
  has_many :notifications, dependent: :destroy, foreign_key: :recipient_id
  has_many :reviews,       dependent: :destroy
  has_many :orders,        dependent: :nullify
  has_one  :avatar,        dependent: :destroy

  delegate :image, to: :avatar, allow_nil: true

  scope :drivers, -> { where(driver: true) }

  acts_as_messageable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

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
end
