# WebMoney message
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

Model = require('./model')

# Message

class Message extends Model
	# Sends message to recipient. CREATE & READ

	send: (callback) ->
		data = message: @data

		@service.invoke('XMLSendMsg', data, callback)	# X6 call

		@

# Exported objects

module.exports = Message
