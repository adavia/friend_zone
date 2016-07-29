class Application.Messages
  constructor: (el) ->
    @messages = $("[data-behavior='messages']")

    if @messages.length > 0
      @handleSuccess @messages.data("messages")

      $("[data-behavior='messages-link']").on "click", (e) =>
        if @messages.data("messages").length > 0
          @markAsRead()

  markAsRead: ->
    $.ajax
      url: "/messages/read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("#unread-messages").text("")

  handleSuccess: (data) ->
    container = $("#messages-list")

    items = $.map data, (msg) ->
      msg.template

    unread_count = 0
    $.each data, (i, message) ->
      if message.unread
        unread_count += 1

    $("#unread-messages").text(parseInt(unread_count) || "")
    if items.length > 0
      container.html(items)
    else
      container.html('<div class="default-message">NO CURRENT MESSAGES!</div>')

$(document).on "turbolinks:load", ->
  new Application.Messages
