class App.User
  constructor: (el) ->
    @el = $(el)

  geolocation: ->
    @el.geocomplete()

$(document).on "turbolinks:load", ->
  return unless $(".registrations.new").length > 0
  user = new App.User $("#user_address")
  user.geolocation()
