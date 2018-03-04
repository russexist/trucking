# frozen_string_literal: true

module OrdersHelper
  def format_uah(value)
    number_to_currency(value, unit: t('helpers.uah'), format: '%n%u', precision: 0)
  end

  def format_weight(value)
    number_to_currency(value, unit: t('helpers.weight'), format: '%n%u', precision: 0)
  end
end
