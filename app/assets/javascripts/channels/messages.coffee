$(document).on "turbolinks:load", ->

  conversation = new Application.Conversation

  content = $(".conversations.show")

  messages = $("#messages-list")

  if content.length > 0
    conversation.loadChannel(messages)
    messages.scrollTop(messages.prop("scrollHeight"))
  else
    conversation.loadChannel(messages).unsubscribe()
