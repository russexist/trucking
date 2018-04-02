class Review < ApplicationRecord
  belongs_to :driver, class_name: 'User', optional: true
  belongs_to :user

  scope :for_driver, -> (user){ where(driver: user).order(created_at: :desc) }
end
