# frozen_string_literal: true

module OrdersHelper
  def format_price(value)
    number_to_currency(value, unit: t('helpers.uah'), format: '%n%u', precision: 0)
  end

  def format_weight(value)
    number_to_currency(value, unit: t('helpers.weight'), format: '%n%u', precision: 0)
  end

  def status_i18n(status)
    case status
    when 'new_order'
      t('status.new')
    when 'taken'
      t('status.taken')
    when 'delivered'
      t('status.delivered')
    end
  end
end
