class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    $("[data-behavior='notification-links']").on "click", @handleClick
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("[data-behavior='unread-count']").text(0)
    )

  handleSuccess: (data) =>
    if data.length > 0
      items = $.map data, (notification) ->
        "<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} #{notification.action}</a>"
      $("[data-behavior='unread-count']").text(items.length)
      $("[data-behavior='notification-items']").html(items)
    else
      $("[data-behavior='unread-count']").text(0)

$(document).on "turbolinks:load", ->
  new Notifications
