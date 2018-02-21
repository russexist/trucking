class Destination < ApplicationRecord
  belongs_to :user

  has_one :order, dependent: :destroy
  has_one :start, through: :order, dependent: :destroy

  validates :destination_point, presence: true
end
