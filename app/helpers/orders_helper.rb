# frozen_string_literal: true

module OrdersHelper
  def format_uah(value)
    number_to_currency(value, unit: " грн.", format: "%n%u", precision: 0)
  end
end
