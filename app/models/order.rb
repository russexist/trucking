# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: ['Новый', 'Принят', 'Доставлен']

  belongs_to :user

  validates :date, :finish_point, :price, :start_point, :weight, presence: true
end
