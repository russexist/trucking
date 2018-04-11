# frozen_string_literal: true

json.array! @uread_notifications do |notification|
  json.id notification.id
  json.actor notification.actor.full_name
  json.action notification.action
  json.url order_path(notification.notifiable)
end
