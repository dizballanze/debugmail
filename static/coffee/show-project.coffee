$ ->
  $(document).on 'click', 'tr.open-row', ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  $('#load-more').click ->
    that = $(this)
    $.get(
      '/project/' + that.attr('data-project-id') + '/' + $('table tr:last').attr 'id'
      (data) ->
        $('table tbody').append(data)
    )
    false