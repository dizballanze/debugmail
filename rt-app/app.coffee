app = require('http').createServer()
socketio = require 'socket.io'
MongoStore = require 'socket.io-mongo'
mubsub = require 'mubsub'


exports.run = (settings)->
  console.log settings
  mubsub_client = mubsub settings.mongodb.url
  app.listen settings.rt.port
  io = socketio.listen app

  io.configure ->
    io.set 'log level', 0
    store = new MongoStore url: settings.mongodb.url
    store.on 'error', console.error
    io.set 'store', store

    io.set 'authorization', (data, accept)->
      if 'uid' of data.query
        accept null, true
      else
        accept null, false

  io.sockets.on 'connection', (socket)->
    uid = socket.handshake.query.uid
    pid = socket.handshake.query.pid

    channel = mubsub_client.channel "project-#{pid}"
    channel.subscribe (letter)->
      socket.emit 'letter', letter

    console.log "user #{uid} connected to project #{pid}"


  console.log "Socket.io running..."