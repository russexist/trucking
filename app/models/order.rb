# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :destination
  belongs_to :start
  belongs_to :user

  delegate :destination_point, to: :destination
  delegate :starting_point, to: :start

  enum status: [I18n.t('status.new'), I18n.t('status.accepted'), I18n.t('status.delivered')]

  self.per_page = 8
  scope :status_new, -> { where(status: 0) }

  validates :date, :price, :weight, presence: true
end
