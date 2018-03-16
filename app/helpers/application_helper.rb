# frozen_string_literal: true

module ApplicationHelper
  def active_page(active_page)
    @active  == active_page ? 'active' : ''
  end

  def flas_class(level)
    case level.to_sym
    when :notice  then "alert alert-success"
    when :info    then "alert alert-info"
    when :alert   then "alert alert-danger"
    when :warning then "alert alert-warning"
    when :success then "alert alert-success"
    end
  end
end
