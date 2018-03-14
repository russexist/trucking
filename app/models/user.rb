# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :archive_orders, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :starts, dependent: :destroy
  has_one  :avatar

  def mailboxer_email(oject); end
end
