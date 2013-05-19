$ ->
  $(document).on 'click' 'tr.open-row' ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  $('#load-more').click ->
    that = $(this)
    $.get(
      that.attr('href')
      (data) ->
        $('table').append(data)
    )
    false