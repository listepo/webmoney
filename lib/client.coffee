# WebMoney client
#
# November, 2012 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

XML = require('xml-objects').XML

# Constants

CLASSIC_HOST = 'w3s.webmoney.ru'	# Default host for signed requests
LIGHT_HOST = 'w3s.wmtransfer.com'	# Default host for requests using client sertificate
MONEY_PORT = 443					# Default port for connections

# WebMoney client

class Client
	# Object constructor

	constructor: (@wmid, @host, @port) ->
	
	# Assembles request from provided data
	
	assembleRequest: (container, data) -> XML.stringify('w3s.request': (wmid: @wmid))

	# Parses response to native data types
	
	parseResponse: (body) -> XML.parse(body)

	# Sends request to payment system
	
	sendRequest: (options) ->
		# Request body

		body = @assembleRequest(options.container, options.data)

		# Request headers

		headers =
			'content-type': 'application/xml'
			'content-length': Buffer.byteLength(body)	# Для какой кодировки?
		
		# Request object

		request = https.request(host: @host, path: '/asp/XML' + options.name + '.asp', method: 'POST', headers: headers)
		
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
				# Assembles body from chunks and parses it

				data = @parseResponse(Buffer.concat(chunks))

				undefined
			)

			undefined
		)

		# Writes data and finishes request

		request.end(body)
		
		@

	# Creates function for calling API method with given name
	
	@createMethod: (name, container) -> (first) ->
		options = name: name, container: container

		if first instanceof Function then [options.callback] = arguments else [options.data, options.callback] = arguments
		
		@sendRequest(options)

	# Интерфейс X1
	
	createInvoice: @createMethod('Invoice', 'invoice')
	
	# Интерфейс X2
	
	transferMoney: @createMethod('Trans', 'trans')
	
	# Интерфейс X6
	
	sendMessage: @createMethod('SendMsg', 'message')
	
	# Интерфейс X16
	
	createPurse: @createMethod('CreatePurse', 'createpurse')

# Exported objects

exports = module.exports = Client
