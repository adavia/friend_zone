class Application.Conversation
  constructor: (el) ->
    @el = $(el)

  getConversations: ->
    $.ajax
      url: @el.attr("href")
      type: "GET"
      dataType: "script"
      beforeSend: (jqXHR) =>
        $("#conversations-list").html('<div class="default-message">loading..</div>')

  loadChannel: (messages) ->
    App.cable.subscriptions.create {
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

  renderConversation: (data) ->
    $.fancybox
      parent: "body"
      href: "/conversations/#{data.conversation_id}"
      type: "ajax"
      ajax:
        complete: (jqXHR, textStatus) =>
          messages = $("#messages-list")
          messages.scrollTop(messages.prop("scrollHeight"))
          @loadChannel(messages)
      beforeClose: =>
        @loadChannel($("#messages-list")).unsubscribe()

$(document).on "ajax:success", "[data-behavior~=load-conversation]", (e, data) ->
  conversation = new Application.Conversation
  conversation.renderConversation(data)

$(document).on "click", "[data-behavior~=load-conversations]", (event) ->
  conversation = new Application.Conversation @
  conversation.getConversations()

