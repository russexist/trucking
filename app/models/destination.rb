# frozen_string_literal: true

class Destination < ApplicationRecord
  belongs_to :user

  has_one :order, dependent: :destroy
  has_one :start, through: :order, dependent: :destroy

  geocoded_by :destination_point, latitude: :destination_latitude, longitude: :destination_longitude
  after_validation :geocode, if: ->(obj) { obj.destination_point_changed? }
  reverse_geocoded_by :destination_latitude, :destination_longitude, address: :destination_point
  after_validation :reverse_geocode

  validates :destination_point, presence: true if :destination_latitude.empty?
end
