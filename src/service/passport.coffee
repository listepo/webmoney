# WebMoney passport service
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported interfaces: X11, X19

# Required modules

BaseService = require('./base')

# WebMoney passport service

class PassportService extends BaseService
	# Default hosts for requests

	@DEFAULT_HOST: 'passport.webmoney.ru'
	@DEFAULT_HOST_1: 'apipassport.webmoney.ru'

# Exported objects

module.exports = PassportService
