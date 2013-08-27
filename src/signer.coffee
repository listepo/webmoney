# WebMoney signer
#
# June, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

crypto = require('crypto')
BigInteger = require('biginteger').BigInteger

#

class Signer
	# Object constructor

	constructor: (@key) ->

	#

	digest: () ->
		hash = crypto.createHash('md4').update(params.join('')).digest()
		random = crypto.randomBytes(40)
		# data = length + hash + random + padding
		# powMod(data.reverse(), eKey, nKey).reverse()
		console.log hash, random

# Exported objects

module.exports = Signer
