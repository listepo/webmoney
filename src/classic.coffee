# WebMoney classic service
#
# June, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Constants

DEFAULT_HOST = 'w3s.webmoney.ru'	# Default host for connections
DEFAULT_PORT = 443					# Default port for connections

# WebMoney classic service

class Classic
	# Object constructor

	constructor: (@wmid, @key) ->

	# Брать WMID из Signer
	
	prepare: (options) ->
		envelope = reqn: @reqn(), wmid: @wmid, sign: @sign()
		envelope[options.name] = options.data

		'w3s.request': envelope

	# Returns URL path for given method

	path: (options) -> '/asp/XML' + options.name + '.asp'

# Exported objects

module.exports = Classic
