# WebMoney request signer
#
# November, 2012 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

fs = require('fs')
crypto = require('crypto')

# WebMoney request signer

class Signer
	# Sets given keys
	
	setKeys: (@eKey, @nKey) -> @
	
	# Loads keys from file
	
	loadKeys: (wmid, fileName, password) ->
		all = fs.readFileSync(fileName)

		header = all.slice(0, 24)
		keys = all.slice(24)

		# Header and decrypted data

		result = new Buffer(164)

		header.copy(result)
		result.fill(0, 2, 20)
		@decryptKeys(wmid, password, keys).copy(result, 24)

		# MD4 hash for header and decrypted data

		digest = new Buffer(crypto.createHash('md4').update(result).digest(), 'binary')

		#console.log(header)
		#console.log(result)
		
		console.log(digest)
		console.log(header.slice(4, 20))

		# if all is OK

		[@eKey, @nKey] = [1, 2]

		@
	
	# Decrypt keys using wmid and password

	decryptKeys: (wmid, password, data) ->
		console.log(password)
		digest = new Buffer(crypto.createHash('md4').update(wmid + password).digest(), 'binary')

		new Buffer(octet ^ digest[index % digest.length] for octet, index in data)

	# Creates signature for given data
	
	createSignature: (data) ->

# Exported objects

exports = module.exports = Signer
