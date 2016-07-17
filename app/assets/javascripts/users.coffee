class App.User
  constructor: (el) ->
    @el = $(el)

  geolocation: ->
    @el.autocomplete
      source: (request, response) ->
        geocoder = new google.maps.Geocoder()
        geocoder.geocode {
          "address": request.term
        }, (results, status) ->
          if status == google.maps.GeocoderStatus.OK
            response $.map results, (result) ->
              return {
                label: result.formatted_address
                value: result.formatted_address
              }
      minLength: 3
      change: (event, ui) =>
        if ui.item == null or ui.item == undefined
          @el.val("")

$(document).on "turbolinks:load", ->
  user = new App.User $("#user_address")
  user.geolocation()

$(document).on "turbolinks:load", ->
  return unless $(".users.show").length > 0 && $('#scrolling-content').length > 0
  user = new App.Pagination
  user.loadResults()
