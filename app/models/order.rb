# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  enum status: { new_order: 0, taken_order: 1, delivered_order: 2 }

  self.per_page = 8

  scope :taken_for_driver, ->(current_user) { where(status: 1, driver_id: current_user) }

  validates :date, :destination, :price, :start, :weight, presence: true
end
