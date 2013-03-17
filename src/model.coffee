# WebMoney model
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Model

class Model
	# Object constructor

	constructor: () ->

	# Check whether model has been saved

	isNew: () -> not @id?

# Exported objects

module.exports = Model
