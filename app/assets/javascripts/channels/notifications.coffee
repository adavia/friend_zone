App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    #$(".default-message").remove() if $(".default-message").length

    unread = parseInt($("#unread-notifications").text()) || 0
    $("#unread-notifications").text(unread += 1)

    $("#notifications-list").prepend(data["notification"])

    # Called when there's incoming data on the websocket for this channel
