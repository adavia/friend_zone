$(document).on "turbolinks:load", ->

  content = $(".conversations.show")
  messages = $(".conversation")

  if content.length > 0

    messages.scrollTop(messages.prop("scrollHeight"))

    App.messages = App.cable.subscriptions.create {
        channel: "MessagesChannel"
        conversation_id: messages.data("conversation-id")
      },

      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append(data["message"])
        messages.scrollTop(messages.prop("scrollHeight"))
        $("#new_message")[0].reset();
  else if App.messages
    App.messages.unsubscribe()
    App.messages = null
