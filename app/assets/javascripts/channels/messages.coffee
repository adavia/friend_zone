App.Messages = App.cable.subscriptions.create {
    channel: "MessagesChannel"
    conversation_id: $("#messages-list").data("conversation-id")
  },

  connected: ->
    console.log "hi"
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#messages-list").append(data["message"])
    $("#new_message")[0].reset();
