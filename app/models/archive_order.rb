# frozen_string_literal: true

class ArchiveOrder < ApplicationRecord
  belongs_to :user

  enum status: { new_order: 0, taken_order: 1, delivered_order: 2 }

  self.per_page = 8

  def format_date
    date.strftime('%d/%m/%Y')
  end
end
