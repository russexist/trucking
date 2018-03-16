# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :archive_orders, dependent: :destroy
  has_many :orders,         dependent: :destroy
  has_one  :avatar,         dependent: :destroy

  acts_as_messageable

  def mailboxer_email(oject)
    self.email
  end

  def mailboxer_name
    self.name
  end
end
