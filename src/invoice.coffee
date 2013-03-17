# WebMoney invoice
#
# March, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

Model = require('./model')

# Invoice

class Invoice extends Model
	# Saves invoice to the server. CREATE & READ

	save: (callback) ->
		data = invoice: amount: @amount, desc: @description

		@service.invoke('XMLInvoice', data, callback)	# X1 call

		@

	# Pays invoice. Remove maybe?

	pay: (callback) ->
		data = trans: pursesrc: @source, pursedest: @destination

		@service.invoke('XMLTrans', data, callback)	# X2 call

		@

# Exported objects

module.exports = Invoice
