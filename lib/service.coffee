# WebMoney base transport
#
# November, 2012 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

https = require('https')
iconv = require('iconv-lite')
XML = require('xml-objects').XML

# WebMoney base transport

class Transport
	# Returns headers for given request body

	headers: (body, charset) ->
		'content-type': 'application/xml; charset=' + if charset? then charset else 'utf-8'
		'content-length': body.length

	# Parses response body (assuming default body charset is UTF-8)
	
	parse: (body, charset) -> XML.parse(iconv.decode(body, charset))

	# Invokes pointed method on payment system
	
	invokeMethod: (options) ->
		# Request body

		body = @assembleBody(options.data)
		
		# Request object

		request = https.request(host: @host, port: @port, path: @path(options.name), method: 'POST', headers: @headers(body))
		
		# On-response handler for request

		request.on('response', (response) =>
			# Array for response chunks

			chunks = []

			# On-data handler for response

			response.on('data', (chunk) =>
				# Pushes arrived chunk to the array

				chunks.push(chunk)

				undefined
			)

			# On-end handler for response

			response.on('end', () =>
				# Combines body from chunks and parses it

				data = @parseBody(Buffer.concat(chunks))

				#

				options.callback?.call(null, null, data)

				undefined
			)

			undefined
		)

		# On-error handler for request

		request.on('error', (error) =>
			# Notifies application about error

			options.callback?.call(@, error)

			undefined
		)

		# Writes data and finishes request

		request.end(body)
		
		@

# Exported objects

exports = module.exports = Transport
