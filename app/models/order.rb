# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { new_order: 0, taken: 1, delivered: 2 }

  belongs_to :driver, class_name: 'User', optional: true
  belongs_to :user
  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :archived_for_user, ->(user) { where(status: 2, driver: user) }
  scope :taken_by_driver, ->(user) { where(status: 1, driver: user) }

  validates :date, :destination, :price, :start, :weight, presence: true

  self.per_page = 15

  def create_notification(recipient, actor, action)
    Notification.create!(recipient: recipient, actor: actor,
                         action: action, notifiable: self)
  end

  def format_date
    date.strftime('%d/%m/%Y')
  end
end
