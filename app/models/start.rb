# frozen_string_literal: true

class Start < ApplicationRecord
  belongs_to :user

  has_one :order, dependent: :destroy
  has_one :destination, through: :order, dependent: :destroy

  validates :starting_point, presence: true
end
