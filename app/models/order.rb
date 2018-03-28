# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  enum status: { new_order: 0, taken: 1, delivered: 2 }

  self.per_page = 8

  scope :taken_for_driver, ->(current_user) { where(status: 1, driver_id: current_user) }

  validates :date, :destination, :price, :start, :weight, presence: true

  def format_date
    date.strftime('%d/%m/%Y')
  end
end
