class Application.Conversation
  renderConversation: (data) ->
    $.fancybox
      parent: "body"
      href: "/conversations/#{data.conversation_id}",
      type: "ajax"
      ajax:
        complete: (jqXHR, textStatus) ->
          App.Messages.connected

$(document).on "ajax:success", "[data-behavior~=load-conversation]", (e, data) ->
  conversation = new Application.Conversation
  conversation.renderConversation(data)

