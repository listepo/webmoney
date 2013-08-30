# WebMoney signer
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

crypto = require('crypto')
BigNum = require('bignum')

# Turn on or turn off generation of random data in signature

DEBUG = false

#

HEADER_SIZE = 2
HASH_START = HEADER_SIZE
RANDOM_SIZE = 40

#

class Signer
	# Object constructor

	constructor: (@key) ->

	# Returns digest of provided message

	digest: (message) ->
		hash = crypto.createHash('md4').update(message).digest()

		blob = new Buffer(HEADER_SIZE + hash.length + RANDOM_SIZE)

		blob.writeUInt16LE(blob.length - HEADER_SIZE, 0)
		hash.copy(blob, HASH_START)
		
		unless DEBUG then crypto.randomBytes(RANDOM_SIZE).copy(blob, HASH_START + hash.length)
		else blob.fill(0, HASH_START + hash.length)

		blobNumber = BigNum.fromBuffer(blob, endian: 'little', size: 'auto')
		expNumber = BigNum.fromBuffer(@key.exponent, endian: 'little', size: 'auto')
		modNumber = BigNum.fromBuffer(@key.modulus, endian: 'little', size: 'auto')

		signNumber = blobNumber.powm(expNumber, modNumber)
		
		Array::reverse.call(signNumber.toBuffer(endian: 'little', size: 2)).toString('hex')

# Exported objects

module.exports = Signer
