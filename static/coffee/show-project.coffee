$ ->
  $('.open-row').click ->
    console.log @.next()
    @.next().toggleClass 'hide'