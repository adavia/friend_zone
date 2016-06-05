# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Post
  constructor: (el) ->
    @el = $(el)

  submit: ->
    @el.ajaxSubmit
      url: @el.attr("action")
      type: "POST"
      dataType: "script"
      data: @el.serialize()
      beforeSend: (jqXHR) =>
        token = $('meta[name="csrf-token"]').attr("content")
        jqXHR.setRequestHeader "X-CSRF-Token", token
      complete: (jqXHR, textStatus) =>
        @toggleButton(false, "Publish")

  toggleButton: (status, text) ->
    button = @el.find($('input[name="commit"]'))
    button.prop("disabled", status)
    button.val(text)

$(document).on "change", "[data-behavior~=upload-post-image]", (event) ->
  return unless $(".posts.index").length > 0
  post = new App.Image @
  post.previewImages()

$(document).on "submit", "[data-behavior~=submit-post]", (event) ->
  return unless $(".posts.index").length > 0
  event.preventDefault()
  post = new App.Post @
  post.toggleButton(true, "Publishing..")
  post.submit()
