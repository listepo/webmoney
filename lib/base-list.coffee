# Webmoney base list
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# BaseList class

class BaseList
	# Object constructor

	constructor: (@service) ->

	# Filter items using provided selector

	filter: (condition) ->
		if condition? then @$filter = condition else delete @$filter

		@

	# Skip pointed number of items

	skip: (count) ->
		if count? then @$skip = count else delete @$skip

		@

	# Limit number of items

	limit: (count) ->
		if count? then @$limit = count else delete @$limit

		@

# Exported objects

module.exports = BaseList