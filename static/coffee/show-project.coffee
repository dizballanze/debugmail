$ ->
  $(document).on 'click', 'tr.open-row', ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  $('#load-more').click ->
    project_id = $(this).attr('data-project-id')
    $.get(
      '/project/' + project_id + '/' + $('table tr:last').attr 'id'
      (data) ->
        $('table tbody').append(data)
        $.get(
          '/has_more_letters/' + project_id + '/' + $('table tr:last').attr 'id'
          (data) ->
            data = JSON.parse data
            console.log data
            console.log data.result
        )
    )
    false