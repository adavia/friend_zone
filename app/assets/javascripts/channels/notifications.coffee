if $("meta[name='current_user']").length > 0
  App.notifications = App.cable.subscriptions.create "NotificationsChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      if data["notification"]
        unread = parseInt($("#unread-notifications").text()) || 0
        $("#unread-notifications").text(unread += 1)
      else if data["message"]
        unread = parseInt($("#unread-conversations").text()) || 0
        $("#unread-conversations").text(unread += 1)
      # Called when there's incoming data on the websocket for this channel
