# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :driver, class_name: 'User'
  belongs_to :user

  scope :for_driver, ->(user) { where(driver: user).order(created_at: :desc) }

  validates :body, presence: true

  self.per_page = 5
end
