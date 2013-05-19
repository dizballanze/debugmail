$ ->
  $('.open-row').click ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  $('#load-more').click ->
    that = $(this)
    $.get(
      that.attr('href')
      (data) ->
        console.log data
    )
    false