$ ->
  $('.open-row').click ->
    console.log $(this).attr 'data-letter-id'
    $('#' + @.attr 'data-letter-id').toggleClass 'hide'