get_letter = (letter)->
  letter.plain = letter.plain.replace /[\n|\r\n]+/, "<br>"
  letter.content = letter.content.replace "\n", "<br>"
  console.log letter
  html_class = if letter.html? then '' else 'disabled'
  headers = ''
  for key,value of letter.headers
    headers += "<strong>#{key}:</strong>#{value}<br>"
  letter_template = """
    <tr class="open-row" data-letter-id="#{letter.id}" style="display: none">
        <td>#{letter.subject}</td><td>now</td>
    </tr>
    <tr class="info hide" id="#{letter.id}" data-letter-subject="#{letter.subject}">
        <td colspan="2">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#info-#{letter.id}" data-toggle="tab">Info</a></li>
                <li><a href="#content-#{letter.id}" data-toggle="tab">Text</a></li>
                <li class="#{html_class}"><a href="#html-#{letter.id}" data-toggle="tab">Html</a></li>
                <li><a href="#plain-#{letter.id}" data-toggle="tab">Plain</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active in" id="info-#{letter.id}">
                    <strong>Link:</strong> <input class="input-xxlarge" type="text" value="http://debugmail.info/#{letter.id}/" disabled>
                    <a class="get-short-link" href="http://debugmail.info/#{letter.id}/">Short link</a><br>
                    <strong>From:</strong> #{letter.sender}<br>
                    <strong>To:</strong> #{letter.to}<br>

                    #{headers}
                </div>
                <div class="tab-pane fade" id="content-#{letter.id}">
                    #{letter.content}
                </div>
                <div class="tab-pane fade" id="html-#{letter.id}">
                    #{letter.html}
                </div>
                <div class="tab-pane fade" id="plain-#{letter.id}">
                    #{letter.plain}
                </div>
            </div>
        </td>
    </tr>
  """

$ ->
  socket = io.connect location.hostname + ':' + port + "/?uid=#{uid}&pid=#{pid}"

  socket.on "letter", (letter)->
    tmpl = get_letter letter
    tr = $(tmpl)
    $('#letters tbody').prepend tr
    tr.filter(':first').show 1000

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
