# WebMoney w3 service
#
# September, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

BaseService = require('./base')
Signer = require('../signer')

#

class Envelope
	#

	generateRequestNumber: () -> 3

	#

	_unprepare: (envelope) ->
		envelope['w3s.response']

#

class ClassicBinding extends Binding
	# Default host for requests

	@DEFAULT_HOST: 'w3s.webmoney.ru'

	#

	constructor: (intf) ->

	# Returns URL path for given method

	_path: (options) -> '/asp/XML' + options.method + '.asp'

	#

	_prepare: (options) ->
		content = reqn: @generateRequestNumber(), wmid: @wmid
		content[options.container] = options.data

		content.sign = @signer.digest(@_signString(content, options.order))

		'w3s.request': content

#

class LightBinding extends Binding
	# Default host for requests

	@DEFAULT_HOST: 'w3s.wmtransfer.com'

	#

	constructor: (intf) ->

	# Returns URL path for given method

	_path: (options) -> '/asp/XML' + options.method + 'Cert.asp'

	#
	
	_prepare: (options) ->
		content = reqn: @generateRequestNumber()
		content[options.container] = options.data

		'w3s.request': content

#

service = new W3Service.Classic(wmid, key)
service = new W3Service.Light(cert)

service.outInvoices(callback)

# W3 service

W3Service =
	Classic: new ClassicBinding(W3Interface)
	Light: new LightBinding(W3Interface)

# Exported objects

module.exports = W3Service
