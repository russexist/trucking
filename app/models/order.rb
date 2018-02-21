# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: %w[Новый Принят Доставлен]

  belongs_to :destination
  belongs_to :start
  belongs_to :user

  delegate :starting_point, to: :start
  delegate :destination_point, to: :destination

  validates :date, :price, :weight, presence: true
end
