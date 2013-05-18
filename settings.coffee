ini = require './smtpd/node_modules/iniparser'
settings = ini.parseSync "#{__dirname}/settings.ini"
settings.mongodb.url = "mongodb://#{settings.mongodb.host}:#{settings.mongodb.port}/#{settings.mongodb.dbname}"

module.exports = exports = settings