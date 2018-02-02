class Order < ApplicationRecord
  belongs_to :user

  validates :start_point, :finish_point, :price, :weight, presence: true
end
