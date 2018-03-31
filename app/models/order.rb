# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { new_order: 0, taken: 1, delivered: 2 }

  belongs_to :driver, class_name: 'User', optional: true
  belongs_to :user

  scope :archived_for, ->(user) { where(status: 2, driver: user) }
  scope :taken_by_driver, ->(user) { where(status: 1, driver: user) }

  validates :date, :destination, :price, :start, :weight, presence: true

  self.per_page = 15

  def format_date
    date.strftime('%d/%m/%Y')
  end
end
