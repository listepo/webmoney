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

# WebMoney service

class Service
	# Serializes provided data

	serialize: (data) -> iconv.encode(XML.stringify(data), 'utf-8')

	# Parses privided data

	parse: (data) -> XML.parse(iconv.decode(data, 'utf-8'))

	# Returns headers for given request body

	headers: (body) ->
		'content-type': 'application/xml; charset=' + @charset
		'content-length': body.length

	# Invokes pointed method on the server
	
	invoke: (options) ->
		# Request body

		body = @serialize(@prepare(options.data))

		# Create request

		request = https.request(host: @host, port: @port, method: options.method, path: @path(options), headers: @headers(body))

		# Assign event handlers for request

		request.on('response', (response) ->
			# Array for response chunks

			chunks = []

			# Assign event handlers for response

			response.on('readable', () ->
				# Push arrived data to the array

				chunks.push(response.read())

				undefined
			)

			response.on('end', () ->
				# Combine body from chunks and parse it

				data = Buffer.concat(chunks)

				# Error handling

				options.callback?(null, data)

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
