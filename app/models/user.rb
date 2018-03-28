# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :archive_orders, dependent: :destroy
  has_many :orders,         dependent: :destroy
  has_one  :avatar,         dependent: :destroy

  acts_as_messageable

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
