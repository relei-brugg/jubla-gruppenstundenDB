ready = ->

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
    stars = $(element).data("star-value")
    setStars(stars)

  resetStars = () ->
    stars = $('#rating-value').val()
    setStars(stars)

  $ ->
    $("span[data-star-value]").click ->
      star_value = $(this).data("star-value")
      $('#rating-value').val(star_value)

      $('form#rating_form').trigger('submit.rails');

  $ ->
    $("span[data-star-value]").hover(
      (-> previewStars(this)),
      (-> resetStars())
    )


$(document).ready(ready)
$(document).on('page:load', ready)