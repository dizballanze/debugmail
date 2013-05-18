ini = require './smtpd/node_modules/iniparser'
mongoose = require './smtpd/node_modules/mongoose'
settings = ini.parseSync "#{__dirname}/settings.ini"
settings.mongodb.url = "mongodb://#{settings.mongodb.host}:#{settings.mongodb.port}/#{settings.mongodb.dbname}"

settings.getConnection = ->
  return mongoose.createConnection settings.mongodb.url, db: {w: 1}

module.exports = exports = settings