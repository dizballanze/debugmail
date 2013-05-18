$ ->
  $('.open-row').click ->
    console.log @
    @.next().toggleClass 'hide'