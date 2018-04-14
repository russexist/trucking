# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all

  def create_notification(recipient, actor, action)
    Notification.create!(recipient: recipient, actor: actor,
                         action: action, notifiable: self)
  end
end
