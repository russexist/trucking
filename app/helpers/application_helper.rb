# frozen_string_literal: true

module ApplicationHelper
    def flas_class(level)
    case level.to_sym
    when :notice  then "alert alert-success"
    when :info    then "alert alert-info"
    when :alert   then "alert alert-danger"
    when :warning then "alert alert-warning"
    end
  end
end
