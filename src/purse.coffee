# WebMoney purse
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

Model = require('./model')

# Purse

class Purse extends Model
	# Creates new purse. CREATE & READ

	save: (callback) ->
		data = createpurse: wmid: @wmid, pursetype: 'R', desc: @description

		@service.invoke('XMLCreatePurse', data, callback)	# X16 call

		@

# Exported objects

module.exports = Purse
