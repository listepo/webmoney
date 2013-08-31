# WebMoney key
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

fs = require('fs')
crypto = require('crypto')

# Constants

HEADER_SIZE = 24        # Header size

FLAG_START = 2          # Flag start position in header
CRC_START = 4           # CRC start position in header
CRC_END = 20            # CRC end position in header
LENGTH_START = 20       # Length start position in header

KEY_SIZE = 140          # Key extected size
EXPONENT_START = 6      # Exponenta start position in keys

# WebMoney key

class Key
	# Decrypts keys using wmid and password

	decryptKeys = (keys, wmid, password) ->
		# Digest to be used as key during decryption
		
		digest = crypto.createHash('md4').update(wmid).update(password).digest()

		# Make simple XOR decryption

		keys[index + 6] = octet ^ digest[index % digest.length] for octet, index in keys.slice(6)

		@

	# Checks data for integrity

	checkData = (header, keys) ->
		# Save reference CRC

		crc = header.toString('hex', CRC_START, CRC_END)

		# Fill required fields with zeros

		header.fill(0, FLAG_START, CRC_END)
		
		# Calculate actual CRC

		crypto.createHash('md4').update(header).update(keys).digest('hex') is crc

	# Parses buffer with keys

	parseKeys = (keys) ->
		# Extrack exponent and modulus from decrypted data

		exponent = keys.slice(EXPONENT_START, EXPONENT_START + keys.readUInt16LE(4))
		modulus = keys.slice(EXPONENT_START + exponent.length + 2, EXPONENT_START + exponent.length + 2 + keys.readUInt16LE(EXPONENT_START + exponent.length))

		# Returns new key object

		new Key(exponent, modulus)

	# Load keys from buffer

	@fromBuffer: (header, keys, wmid, password) ->
		# Decrypt keys

		decryptKeys(keys, wmid, password)

		# Check keys for integrity

		checkData(header, keys)

		# Returns key object with parsed keys

		parseKeys(keys)

	# Loads keys from file
	
	@fromFile: (fileName, wmid, password) ->
		# Open file for reading

		file = fs.openSync(fileName, 'r')

		# Read header from file

		header = new Buffer(HEADER_SIZE)
		fs.readSync(file, header, 0, header.length)

		# Read keys from file

		keys = new Buffer(header.readUInt32LE(LENGTH_START))
		fs.readSync(file, keys, 0, keys.length)
		
		# Close file
		
		fs.closeSync(file)

		#

		@fromBuffer(header, keys, wmid, password)
	
	# Object constructor

	constructor: (@exponent, @modulus) ->

# Exported objects

module.exports = Key
