$ ->
  $(document).on 'click', 'tr.open-row', ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  $('#load-more').click ->
    project_id = $(this).attr('data-project-id')
    $.get(
      "/project/#{project_id}/" + $('table tr:last').attr 'id'
      (data) ->
        $('table tbody').append(data)
        $.get(
          "/has_more_letters/#{project_id}/" + $('table tr:last').attr 'id'
          (data) ->
            data = JSON.parse data
            $('#load-more').addClass('hide') unless data.result
        )
    )
    false

  $(document).on 'click', 'a.get-short-link', ->
    url = $(this).attr 'href'
    console.log(url)
    $.ajax(
      url: "http://qps.ru/api?url=#{url}&format=text"
      dataType: 'jsonp'
      crossDomain: true
      type: 'GET'
      success: (data) ->
        console.log data
    )
    false