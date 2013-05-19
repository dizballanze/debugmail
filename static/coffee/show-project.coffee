$ ->
  $('.open-row').click ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'