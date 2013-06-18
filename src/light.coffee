# WebMoney light service
#
# June, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Constants

DEFAULT_HOST = 'w3s.wmtransfer.com'	# Default host for connections
DEFAULT_PORT = 443					# Default port for connections

# WebMoney light service

class Light
	# Object constructor

	constructor: () ->

	# Брать WMID из Signer
	
	prepare: (options) ->
		envelope = reqn: @reqn()
		envelope[options.name] = options.data

		'w3s.request': envelope

	# Returns URL path for given method

	path: (options) -> '/asp/XML' + options.name + 'Cert.asp'

# Exported objects

module.exports = Light
