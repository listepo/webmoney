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

# Turn off or turn on generation of random data in signature

DEBUG = false

#

INT16_SIZE = 2
HASH_START = INT16_SIZE
RANDOM_SIZE = 40

# Signer class

class Signer
	# Object constructor

	constructor: (key) ->
		@_exponent = BigNum.fromBuffer(key.exponent, endian: 'little', size: 'auto')
		@_modulus = BigNum.fromBuffer(key.modulus, endian: 'little', size: 'auto')

	# Returns digest of provided message

	digest: (message) ->
		# Generate hash from provided message and some random data

		hash = crypto.createHash('md4').update(message).digest()
		random = crypto.randomBytes(RANDOM_SIZE) unless DEBUG

		# Create blob and fill it with required data

		actualSize = hash.length + RANDOM_SIZE

		blob = new Buffer(INT16_SIZE + actualSize)
		blob.writeUInt16LE(actualSize, 0)

		hash.copy(blob, HASH_START)

		unless DEBUG then random.copy(blob, HASH_START + hash.length) else blob.fill(0, HASH_START + hash.length)

		# Encrypt blob with RSA using known exponent and modulus

		blobNumber = BigNum.fromBuffer(blob, endian: 'little', size: 'auto')
		signNumber = blobNumber.powm(@_exponent, @_modulus)
		
		Array::reverse.call(signNumber.toBuffer(endian: 'little', size: 2)).toString('hex')

# Exported objects

module.exports = Signer
