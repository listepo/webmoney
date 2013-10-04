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

	_fieldValue: (object, path) ->
		result = object

		result = result[key] for key in path.split('.')

		result

	#

	_signString: (envelope, order) ->
		result = []

		result.push(@_fieldValue(envelope, path)) for path in order

		result.join('')

	#

	invoke: (method, data, callback) ->
		methodDef = @constructor.METHODS[method]

		envelope = @_prepareClassic(data: data, container: methodDef.container, order: methodDef.order)

		[body, headers] = filters.serialize(envelope, 'application/xml')

		path = @_pathClassic(method: method)

		request = https.request(host: @host, port: @port, method: 'POST', path: path, headers: headers, rejectUnauthorized: false)

		request.on('response', (response) =>
			response.readAll((error, data) =>
				#console.log response.headers

				console.log @_unprepare(filters.parse(response.headers, data))

				undefined
			)
		)

		request.on('error', (error) ->
			# Error handling

			callback?(error)

			undefined
		)

		console.log data
		console.log ''

		request.end(body)

		@

# Exported objects

module.exports = BaseService
