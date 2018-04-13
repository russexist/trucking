# frozen_string_literal: true

module ApplicationHelper
  def active_page(active_page)
    @active == active_page ? 'active' : ''
  end

  def flas_class(level)
    case level.to_sym
    when :notice  then 'alert success'
    when :info    then 'alert info'
    when :alert   then 'alert danger'
    when :warning then 'alert warning'
    end
  end
end
