# frozen_string_literal: true

class Start < ApplicationRecord
  belongs_to :user

  has_one :order, dependent: :destroy
  has_one :destination, through: :order, dependent: :destroy

  geocoded_by :starting_point, latitude: :start_latitude, longitude: :start_longitude
  after_validation :geocode, :if => lambda{ |obj| obj.starting_point_changed? }
  reverse_geocoded_by :start_latitude, :start_longitude, address: :starting_point
  after_validation :reverse_geocode

  validates :starting_point, presence: true
end
