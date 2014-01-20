# WebMoney service
#
# June, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

https = require('https')

XML = require('../../../xml-objects').XML
filters = require('../../../../http-helpers')
filters.patch()
filters.SERIALIZERS['application/xml'] = (data) -> XML.stringify(data)
filters.PARSERS['text/xml'] = (body) -> XML.parse(body)

# Разделить
# - авторизацию (Classic, Light), список полей для подписи
# - хост, порт, путь, контейнер

# WebMoney service

class BaseService
	# Default port for requests

	@DEFAULT_PORT: 443

	# Object constructor

	constructor: (host, port = @constructor.DEFAULT_PORT) ->
		throw new Error('Host should be a string') if typeof host isnt 'string'
		throw new Error('Port should be a number') if typeof port isnt 'number'

		@host = host
		@port = port

	#

	invoke: (method, input, callback) ->
		envelope = @_prepare(output, definition)

		request = https.request(@_makeOptions(definition))

		request.on('response', (response) =>
			response.readAll((error, data) =>
				data = @_unprepare(filters.parse(response.headers, data))

				callback?(null, data)

				undefined
			)

			undefined
		)

		request.on('error', (error) ->
			callback?(error)

			undefined
		)

		request.sendXML(envelope)

		@

	#

	@createService: (intf) ->

	# Creates implementation for provided method definition

	@createMethod: (definition) ->
		(output, callback) -> @invoke(definition, output, callback)

# Exported objects

module.exports = BaseService
