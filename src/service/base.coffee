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

class Service
	# Serializes provided data

	_serialize: (data) -> iconv.encode(XML.stringify(data), @charset)

	#

	_body: (options) -> @_serialize(@_prepare(options))

	# Returns headers for given request body

	_headers: (body) ->
		'Content-Type': 'application/xml; charset=' + @charset
		'Content-Length': body.length

	# Parses privided data

	_data: (body) -> iconv.decode(body, 'utf-8')	# Заменить на options

	# Invokes pointed method on the server
	
	invoke: (options) ->
		# Prepare request body and headers

		body = @_body(options)
		headers = @_headers(body)
		path = @_path(options)

		console.log body.toString()

		# Create request

		request = https.request(host: @host, port: @port, method: 'POST', path: path, headers: headers, rejectUnauthorized: false)

		# Assign event handlers for request

		request.on('response', (response) =>
			# Array for response chunks

			chunks = []

			# Assign event handlers for response

			response.on('readable', () ->
				# Push arrived data to the array

				chunks.push(response.read())

				undefined
			)

			response.on('end', () =>
				# Combine body from chunks and parse it

				data = Buffer.concat(chunks)

				# Error handling

				options.callback?(null, @_parse(data))

				undefined
			)

			undefined
		)

		request.on('error', (error) ->
			# Error handling

			options.callback?(error)

			undefined
		)

		# Write body and finish request

		request.end(body)

		@

# Exported objects

module.exports = Service
