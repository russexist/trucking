class Order < ApplicationRecord
  enum status: {
    'Новый' => 0,
    'Принят' => 1,
    'Доставлен' => 2
  }

  belongs_to :user

  validates :start_point, :finish_point, :price, :weight, presence: true
end
