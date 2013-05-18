ini = require './smtpd/node_modules/iniparser'
settings = ini.parseSync "#{__dirname}/settings.ini"

module.exports = exports = settings