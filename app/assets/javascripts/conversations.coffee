class App.Conversation
  renderConversation: (data) ->
    $.fancybox
      parent: "body"
      href: "/conversations/#{data.conversation_id}",
      type: "ajax"

$(document).on "ajax:success", "[data-behavior~=load-conversation]", (e, data) ->
  conversation = new App.Conversation
  conversation.renderConversation(data)

