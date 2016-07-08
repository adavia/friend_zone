window.App ||= {}

App.init = ->
  $("a.fancybox").fancybox
    parent: "body"
    autoSize: false
    beforeLoad: ->
      url = $(@element).attr("href")
      this.href = url
    type: "ajax"

$(document).on "turbolinks:load", ->
  App.init()
