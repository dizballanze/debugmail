smtp = require "simplesmtp"


exports.run = (settings)->
  server = smtp.createServer 
    name: 'localhost'
    debug: true
    maxSize: 5 * 1024
    requireAuthentication: true
    disableDNSValidation: true
    authMethods: ['LOGIN', 'PLAIN']

  server.on 'startData', (req)->
    req.data = ''

  server.on 'data', (req, chunk)->
    req.data += chunk
    
  server.on 'dataReady', (req, cb)->
    console.log req.data
    cb null, 'OK'

  server.on 'authorizeUser', (connection, username, password, callback)->
    callback null, true

  server.listen 9025

  console.log "Running..."