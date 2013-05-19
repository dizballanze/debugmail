$ ->
  $(document).on 'click', 'tr.open-row', ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  $('#load-more').click ->
    that = $(this)
    console.log $('table tr:last').attr('id')
    $.get(
      that.attr('href')
      (data) ->
        $('table tbody').prepend(data)
    )
    false