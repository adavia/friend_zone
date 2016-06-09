class App.Image
  constructor: (el) ->
    @el = $(el)
    $(".wrapper-img").remove()
    @el.parents("form").append('<div class="wrapper-img">')

  previewImages: ->
    dvPreview = $(".wrapper-img")
    if typeof FileReader != "undefined"
      regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/
      if !(@el[0].files.length > 3)
        $(@el[0].files).each ->
          file = $(@)
          if regex.test(file[0].name.toLowerCase())
            reader = new FileReader
            reader.onload = (e) ->
              img = $("<img />")
              img.attr "class", "img-preview"
              img.attr "src", e.target.result
              dvPreview.append img
            reader.readAsDataURL file[0]
            console.log file[0].size
          else
            dvPreview.html('<p class="text-danger">' + file[0].name +
            ' is not a valid image file.' +
            '</p>')
      else
        dvPreview.html('<p class="text-danger">You can upload 3 files max.</p>')
    else
      dvPreview.html('<p class="text-danger">
        This browser does not support HTML5 FileReader.</p>')
