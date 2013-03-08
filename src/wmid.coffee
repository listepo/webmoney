# WebMoney WMID
#
# January, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

Purses = require('./purse-list')
Invoices = require('./invoice-list')

# WebMoney WMID

class WMID
	# Object constructor

	constructor: (@service) ->

	#

	purses: () -> new Purses()

	#

	invoices: () -> new Invoices()

	#

	passport: (callback) ->
		@

# Exported objects

module.exports = WMID
