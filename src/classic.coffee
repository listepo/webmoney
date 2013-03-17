# WebMoney classic service
#
# December, 2012 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

crypto = require('crypto')
BigNum = require('bignum')
WebService = require('../../web-client').WebService

# WebMoney classic service

class ClassicService extends WebService
	# Hide service properties

	Object.defineProperty(@, '__super__', enumerable: false)
	
	# Constants

	@DEFAULT_HOST: 'w3s.webmoney.ru'	# Default host for connections
	@DEFAULT_PORT: 443					# Default port for connections

	# Object constructor

	constructor: (@wmid, @key, host = @constructor.DEFAULT_HOST, port = @constructor.DEFAULT_PORT) -> super(host, port)

	# Returns URL path for given method

	path: (options) -> '/asp/XML' + options.name + '.asp'

	# Returns headers for given request body

	headers: (body) ->
		'content-type': 'application/xml; charset=' + @charset
		'content-length': body.length
	
	# Signes provided data

	signData: (data) ->
		data = '2383300783891LoveHello'
		test = new Buffer('882c29241827a5fb686c9a1146fe2008a38e6278d2ce7d26c394a69ce0c5d56172233937d962cd6fbe428af2be77461328bc94ba47153a2a7481085f1a8cdf120527', 'hex')
		
		digest = crypto.createHash('md4').update(data, 'utf-8').digest()

		buffer = new Buffer(digest.length + 42)

		#offset = @key.modulus.length - (digest.length + 42)

		buffer.writeUInt16LE(buffer.length - 2, 0)
		buffer.write(digest, 2, 'binary')
		buffer[2 + digest.length + index] = Math.round(Math.random() * 255) for index in [0..39]

		input = BigNum.fromBuffer(buffer, endian: 'little', size: @key.modulus.length)
		console.log input

		# Make signature

		signature = input.powm(BigNum.fromBuffer(@key.exponent), BigNum.fromBuffer(@key.modulus)).toBuffer(endian: 'little', size: @key.modulus.length)

		console.log(test)
		console.log(signature.length)

		signature.toString('hex')

	# Assembles request body from provided data (assuming default body charset is UTF-8)
	
	assembleBody: (options) ->
		envelope = 'w3s.request': reqn: 1, wmid: @wmid, sign: @signData(), message: data

		iconv.encode(XML.stringify(envelope), @charset)

# Exported objects

module.exports = ClassicService
