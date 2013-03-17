# WebMoney light service
#
# December, 2012 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

WebService = require('../../web-client').WebService

# WebMoney light service

class Light extends WebService
	# Hide service properties

	Object.defineProperty(@, '__super__', enumerable: false)
	
	# Constants

	@DEFAULT_HOST: 'w3s.wmtransfer.com'	# Default host for connections
	@DEFAULT_PORT: 443					# Default port for connections

	# Object constructor

	constructor: (@pfx, host = @constructor.DEFAULT_HOST, port = @constructor.DEFAULT_PORT) -> super(host, port)

	# Returns URL path for given method

	path: (options) -> '/asp/XML' + options.name + 'Cert.asp'

	# Returns headers for given request body

	headers: (body) ->
		'content-type': 'application/xml; charset=' + @charset
		'content-length': body.length

	# Assembles request body from provided data (assuming default body charset is UTF-8)
	
	assembleBody: (options) ->
		@assembleXML('w3s.request': options.data)

		'<w3s.request><reqn>1</reqn><message></message></w3s.request>'

	#

	parseBody: (data) -> data: data.toString()

# Exported objects

module.exports = Light
