$ ->
  $('.open-row').click ->
    $('#' + $(this).attr 'data-letter-id').toggleClass 'hide'

  socket = io.connect location.hostname + ':' + port + "/?uid=#{uid}&pid=#{pid}"

  socket.on "letter", (data)->
    console.log "New data", data
