$ ->
  $('.open-row').click ->
    console.log @.attr 'data-letter-id'
    $('#' + @.attr 'data-letter-id').toggleClass 'hide'