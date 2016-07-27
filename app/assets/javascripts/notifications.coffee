class Application.Notification
  constructor: (el) ->
    @el = $(el)

  getNotifications: ->
    $.ajax
      url: @el.attr("href")
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
      beforeSend: (jqXHR) =>
        $("#notifications-list").html('<div class="default-message">loading..</div>')
      complete: (jqXHR, textStatus) =>
        @markAsRead() if jqXHR.responseJSON.length > 0

  markAsRead: ->
    $.ajax
      url: "/notifications/read"
      dataType: "JSON"
      method: "POST"

  handleSuccess: (data) ->
    container = $("#notifications-list")

    items = $.map data, (noti) ->
      noti.template

    if items.length > 0
      container.html(items)
    else
      container.html('<div class="default-message">NO ACTIVE NOTIFICATIONS!</div>')

$(document).on "click", "[data-behavior~=load-notifications]", (event) ->
  conversation = new Application.Notification @
  conversation.getNotifications()
  event.preventDefault()
