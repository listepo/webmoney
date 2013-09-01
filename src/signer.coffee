# WebMoney signer
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

DATA_LENGTH_SIZE = 2
HASH_START = DATA_LENGTH_SIZE
RANDOM_SIZE = 40

#

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

		# Create blob buffer and fill it with required data

		blob = new Buffer(DATA_LENGTH_SIZE + hash.length + RANDOM_SIZE)

		blob.writeUInt16LE(blob.length - DATA_LENGTH_SIZE, 0)
		hash.copy(blob, HASH_START)
		
		randomStart = HASH_START + hash.length
		unless DEBUG then random.copy(blob, randomStart) else blob.fill(0, randomStart)

		# Encrypt blob with RSA using known exponent and modulus

		blobNumber = BigNum.fromBuffer(blob, endian: 'little', size: 'auto')
		signNumber = blobNumber.powm(@_exponent, @_modulus)
		
		Array::reverse.call(signNumber.toBuffer(endian: 'little', size: 2)).toString('hex')

# Exported objects

module.exports = Signer
