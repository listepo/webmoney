# WebMoney service
#
# June, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

https = require('https')
iconv = require('iconv-lite')
XML = require('xml-objects').XML

# Разделить
# - авторизацию (Classic, Light), список полей для подписи
# - хост, порт, путь, контейнер

# WebMoney service

class BaseService
	# Default port for requests

	@DEFAULT_PORT: 443

# Exported objects

module.exports = BaseService
