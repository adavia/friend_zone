class Application.Notification
  constructor: (el) ->
    @el = $(el)
    @container = $("#notifications-list")

  getNotifications: ->
    $.ajax
      url: @el.attr("href")
      type: "GET"
      dataType: "script"
      beforeSend: (jqXHR) =>
        @container.html('<div class="default-message">loading..</div>')
      complete: (jqXHR, textStatus) =>
        @markAsRead()

  markAsRead: ->
    $.ajax
      url: "/notifications/read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("#unread-notifications").text("")

$(document).on "click", "[data-behavior~=notifications-link]", (event) ->
  noti = new Application.Notification @
  noti.getNotifications()
  event.preventDefault()
