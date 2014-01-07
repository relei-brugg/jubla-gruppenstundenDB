ready = ->

  ratingSet = () ->
    $('#rating-value').val() != ''

  setStarColor = (color) ->
    $("span[data-star-value]").each ->
      $(this).css('color', color)

  removeStar = (i) ->
    star = $('#rating_star_'+i)
    $(star).removeClass('glyphicon-star')
    $(star).addClass('glyphicon-star-empty')

  addStar = (i) ->
    star = $('#rating_star_'+i)
    $(star).removeClass('glyphicon-star-empty')
    $(star).addClass('glyphicon-star')

  setStars = (stars) ->
    for i in [1..5]
      addStar(i) if i <= stars
      removeStar(i) if i > stars


  previewStars = (element) ->
    setStarColor('black')
    stars = $(element).data("star-value")
    setStars(stars)

  resetStars = () ->
    setStarColor('lightgray') unless ratingSet()
    stars = $('#rating-value').val()
    setStars(stars)

  initStars = () ->
    $("span[data-star-value]").each ->
      $(this).addClass('glyphicon')


  $ ->
    $("span[data-star-value]").click ->
      star_value = $(this).data("star-value")
      $('#rating-value').val(star_value)
      $('form#rating_form').trigger('submit.rails')

  $ ->
    $("span[data-star-value]").hover(
      (-> previewStars(this)),
      (-> resetStars())
    )

  $ ->
    initStars()
    resetStars()

$(document).ready(ready)
$(document).on('page:load', ready)