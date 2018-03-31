# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders, dependent: :nullify
  has_one  :avatar, dependent: :destroy

  acts_as_messageable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def not_driver?
    !driver.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def mailboxer_email(_oject)
    email
  end

  def mailboxer_name
    name
  end
end
