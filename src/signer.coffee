# WebMoney signer for classic authorization
#
# September, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

crypto = require('crypto')
BigNum = require('bignum')

# NOTE
#
# BigNum is very unstable and should be replaced by another library

# Constants for signature layout

INT16_SIZE = 2
HASH_START = INT16_SIZE
RANDOM_SIZE = 40

# Signer class

class Signer
	# Turns off or turns on generation of random data in signature

	@DEBUG: false

	# Object constructor

	constructor: (key, debug = @constructor.DEBUG) ->
		@_exponent = BigNum.fromBuffer(key.exponent, endian: 'little', size: 'auto')
		@_modulus = BigNum.fromBuffer(key.modulus, endian: 'little', size: 'auto')

		@_debug = debug

	# Returns digest of provided message

	digest: (message) ->
		# Generate hash from provided message and some random data

		hash = crypto.createHash('md4').update(message).digest()
		random = crypto.randomBytes(RANDOM_SIZE) unless @_debug

		# Create blob and fill it with required data

		actualSize = hash.length + RANDOM_SIZE

		blob = new Buffer(INT16_SIZE + actualSize)
		blob.writeUInt16LE(actualSize, 0)

		hash.copy(blob, HASH_START)

		unless @_debug then random.copy(blob, HASH_START + hash.length) else blob.fill(0, HASH_START + hash.length)

		# Encrypt blob with RSA using known exponent and modulus

		blobNumber = BigNum.fromBuffer(blob, endian: 'little', size: 'auto')
		signNumber = blobNumber.powm(@_exponent, @_modulus)
		
		Array::reverse.call(signNumber.toBuffer(endian: 'little', size: 2)).toString('hex')

# Exported objects

module.exports = Signer
