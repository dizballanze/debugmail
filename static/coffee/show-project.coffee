$ ->
  $(document).on 'click', 'tr.open-row', ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  $('#load-more').click ->
    project_id = $(this).attr('data-project-id')
    last_letter_id = $('table tr:last').attr 'id'
    $.get(
      '/project/' + project_id + '/' + last_letter_id
      (data) ->
        $('table tbody').append(data)
        $.get(
          '/has_more_letters/' + project_id + '/' + last_letter_id
          (data) ->
            console.log data
        )
    )
    false