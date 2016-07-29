class Application.Notification
  constructor: (el) ->
    @notifications = $("[data-behavior='notifications']")

    if @notifications.length > 0
      @handleSuccess @notifications.data("notifications")

      $("[data-behavior='notifications-link']").on "click", (e) =>
        if @notifications.data("messages").length > 0
          @markAsRead()

  markAsRead: ->
    $.ajax
      url: "/notifications/read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("#unread-notifications").text("")

  handleSuccess: (data) ->
    container = $("#notifications-list")

    items = $.map data, (noti) ->
      noti.template

    unread_count = 0
    $.each data, (i, notification) ->
      if notification.unread
        unread_count += 1

    $("#unread-notifications").text(parseInt(unread_count) || "")
    if items.length > 0
      container.html(items)
    else
      container.html('<div class="default-message">NO CURRENT NOTIFICATIONS!</div>')


$(document).on "turbolinks:load", ->
  new Application.Notification
