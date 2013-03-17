# WebMoney lazy list
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Lazy list

class LazyList
	# Object constructor

	constructor: (@service) ->

	# Filters items using provided selector

	filter: (condition) ->
		if condition? then @$filter = condition else delete @$filter

		@

	# Skips pointed number of items

	skip: (count) ->
		if count? then @$skip = count else delete @$skip

		@

	# Limits number of items

	limit: (count) ->
		if count? then @$limit = count else delete @$limit

		@

	# Fetches selected items from the server

	fetch: (callback) ->
		callback(new Error('Pure virtual method was called!'))

		@

# Exported objects

module.exports = LazyList
