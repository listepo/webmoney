# Copyright QuickSoft LLC

# Required modules

FS = require('fs')
Crypto = require('crypto')

# Constants for header

HEADER_SIZE = 24		# Header size

FLAG_START = 2			# Flag start position in header
CRC_START = 4			# CRC start position in header
CRC_END = 20			# CRC end position in header
LENGTH_START = CRC_END	# Length start position in header

# Constants for body

EXP_LENGTH_START = 4	# Exponent length start position
KEY_DATA_START = 2		# Exponent data start position

# WebMoney key

class Key
	# Decrypts keys using wmid and password

	decryptKeys = (keys, wmid, password) ->
		# Digest to be used as key during decryption
		
		digest = Crypto.createHash('md4').update(wmid).update(password).digest()

		# Make simple XOR decryption

		keys[index + 6] = octet ^ digest[index % digest.length] for octet, index in keys.slice(6)

		undefined

	# Checks data for integrity

	checkData = (header, data) ->
		# Save reference CRC

		crc = header.toString('hex', CRC_START, CRC_END)

		# Fill required fields with zeros

		header.fill(0, FLAG_START, CRC_END)
		
		# Calculate actual CRC

		Crypto.createHash('md4').update(header).update(data).digest('hex') is crc

	# Parses buffer with keys

	parseKeys = (body) ->
		# Extract exponent from decrypted data

		exponent = new Buffer(body.readUInt16LE(4))
		body.copy(exponent, 0, 4 + KEY_DATA_START, 4 + KEY_DATA_START + exponent.length)

		# Extract modulus from decrypted data

		offset = 4 + KEY_DATA_START + exponent.length

		modulus = new Buffer(body.readUInt16LE(offset))
		body.copy(modulus, 0, offset + KEY_DATA_START, offset + KEY_DATA_START + modulus.length)

		# Returns new key object

		new Key(exponent, modulus)

	# Load keys from buffer

	@fromBuffer: (header, body, wmid, password) ->
		# Decrypt keys

		decryptKeys(body, wmid, password)

		# Check keys for integrity

		checkData(header, body)

		# Returns key object with parsed keys

		parseKeys(body)

	# Loads keys from file
	
	@fromFile: (fileName, wmid, password) ->
		# Open file for reading

		file = fs.openSync(fileName, 'r')

		# Read header from file

		header = new Buffer(HEADER_SIZE)
		fs.readSync(file, header, 0, header.length)

		# Read body from file

		body = new Buffer(header.readUInt32LE(LENGTH_START))
		fs.readSync(file, body, 0, body.length)
		
		# Close file
		
		fs.closeSync(file)

		#

		@fromBuffer(header, body, wmid, password)
	
	# Object constructor

	constructor: (exponent, modulus) ->
		throw new TypeError('Exponent can\'t be null or undefined') unless exponent?
		throw new TypeError('Modulus can\'t be null or undefined') unless modulus?

		@exponent = exponent
		@modulus = modulus

# Exported objects

module.exports = Key
