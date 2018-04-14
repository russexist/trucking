# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: %i[new_order taken delivered]

  belongs_to :driver, class_name: 'User', optional: true
  belongs_to :user

  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :archived_for_user, ->(user) { where(status: 2, driver: user) }
  scope :taken_by_driver, ->(user) { where(status: 1, driver: user) }

  validates :date, :destination, :price, :start, :weight, presence: true

  self.per_page = 15

  def format_date
    date.strftime('%d/%m/%Y')
  end
end
