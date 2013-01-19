# WebMoney operations
#
# January, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

extend = require('extend')

# WebMoney operations

class Operations
	# Object constructor

	constructor: (@service) ->
		@query = {}

	#

	filter: (types) ->
		@query.type = (key for key, value of types when value).join(' ')

		@

	#

	from: (time) ->
		@query.datestart = time.toISOString()

		@

	#

	till: (time) ->
		@query.datefinish = time.toISOString()

		@

	#

	info: (callback) ->
		data = extend(details: false, @query)

		@service.invoke(method: 'post', name: 'operation-history', data: data, onComplete: (error, history) ->
			callback(error, history.operations)

			undefined
		)

		@

# Exported objects

module.exports = History
