$ ->
  socket = io.connect location.hostname + ':' + port + "/?uid=#{uid}&pid=#{pid}"

  socket.on "letter", (data)->
    console.log "New data", data

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

    $.ajax(
      url: "http://qps.ru/api?url=#{url}&format=text"
      crossDomain: true
      type: 'GET'
      success: (data) ->
        $("input[value='#{url}']").val(data)
    )
    false

  $('#search-input').keyup ->
    query = $(this).val()
    $('table tr.info').addClass 'hide'
    $("table tr.info[data-letter-subject*='#{query}']").removeClass 'hide'
