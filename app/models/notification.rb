# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true
  belongs_to :recipient, class_name: 'User'

  scope :for_user, ->(user) { where(recipient: user) }
  scope :unread, -> { where(read_at: nil) }

  self.per_page = 20
end
