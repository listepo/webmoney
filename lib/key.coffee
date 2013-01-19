# WebMoney classic key
#
# November, 2012 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

fs = require('fs')
crypto = require('crypto')

# Constants

HEADER_SIZE = 24

# WebMoney clasic key

class Key
	# Sets given keys
	
	setKeys: (@modulus, @exponent) -> @
	
	# Loads keys from file
	
	load: (wmid, fileName, password) ->
		# Opens file for reading

		file = fs.openSync(fileName, 'r')

		# Reads data header from file

		header = new Buffer(HEADER_SIZE)
		fs.readSync(file, header, 0, header.length)
		
		#
		
		crc = header.slice(4, 20)
		length = header.readUInt32LE(20)

		# Reads data itself from file

		data = new Buffer(length)
		fs.readSync(file, data, 0, data.length)
		
		# Closes file
		
		fs.closeSync(file)

		# Header and decrypted data

		result = new Buffer(24)

		keys = @decryptKeys(wmid, password, data)

		# Copies exponent to object property
		
		@exponent = new Buffer(keys.readUInt16LE(4))
		@modulus = new Buffer(keys.readUInt16LE(6 + @exponent.length))
		
		keys.copy(@exponent, 0, 6, 6 + @exponent.length)
		keys.copy(@modulus, 0, position, position + @modulus.length)

		@
	
	# Decrypt keys using wmid and password

	decryptKeys: (wmid, password, data) ->
		digest = new Buffer(crypto.createHash('md4').update(wmid).update(password).digest(), 'binary')

		new Buffer(octet ^ digest[index % digest.length] for octet, index in data)

# Exported objects

exports = module.exports = Key
