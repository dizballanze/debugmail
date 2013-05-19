socketio = require 'socket.io'
MongoStore = require 'socket.io-mongo'


exports.run = (settings)->
  console.log settings
  io = io.listen settings.rt.port

  io.configure ->
    store = MongoStore url: settings.mongodb.url
    store.on 'error', console.error
    io.set 'store', store

    io.set 'authorization', (data, accept)->
      console.log data
      accept null, true

  io.sockets.on 'connection', (socket)->
    console.log 'user connected'

  console.log "Socket.io running..."