class Application.Conversation
  constructor: (el) ->
    @el = $(el)
    @container = $("#conversations-list")

  getConversations: ->
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
      url: "/messages/read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("#unread-conversations").text("")

$(document).on "click", "[data-behavior~=conversations-link]", (event) ->
  msg = new Application.Conversation @
  msg.getConversations()
  event.preventDefault()
