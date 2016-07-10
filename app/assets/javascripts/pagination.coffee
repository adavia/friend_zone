# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Pagination
  loadResults: ->
    $(window).on 'scroll', ->
      res = $('#scrolling-content a').attr('href')
      if res && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('#scrolling-content').html('<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>')
        $.getScript res
