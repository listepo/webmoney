# WebMoney w3 interface
#
# September, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported methods: X1 - X6, X8 - X10, X13 - X16

# Error codes

CODES =
	# Common errors

	INTERNAL_ERROR: 4
	INTERNAL_ERROR: 15
	INTERNAL_ERROR: 19
	INTERNAL_ERROR: 23

	#

	REQN_MUST_BE_GREATER: 102

	# Source and destination ID errors

	INVALID_SOURCE_WMID: 5
	INVALID_DESTINATION_WMID: 6
	INVALID_DESTINATION_PURSE: 7
	INVALID_SOURCE_PURSE: 11

	#

	AMOUNT_LE_ZERO: 13
	INSUFFICIENT_BALANCE: 17

	# Protection code errors

	INVALID_PCODE: 20
	PROTECTION_UNSUPPORTED: 22

	# Invoice errors

	INVALID_INVOICE_ID: 21
	INVOICE_TIMEOUT: 25

	#

	DIFFERENT_PURSES_REQUIRED: 26
	DIFFERENT_PURSE_TYPES: 29
	DIRECT_PAYMENT_NOT_ALLOWED: 30
	NO_PAYMENT_AUTH: 35
	DESTINATION_BALANCE_LIMIT: 58
	TRANS_ID_EXISTS: 103
	NOT_ALLOWED: 110
	NO_TRUST: 111

# W3 interface

W3Interface =
	# X1

	createInvoice:
		path: 'Invoice'
		request: 'invoice'
		order: [
			'invoice.orderid', 'invoice.customerwmid', 'invoice.storepurse'
			'invoice.amount', 'invoice.desc', 'invoice.address'
			'invoice.period', 'invoice.expiration', 'reqn'
		]
		response: 'invoice'

	# X4

	outInvoices:
		path: 'OutInvoices'
		request: 'getoutinvoices'
		order: ['getoutinvoices.purse', 'reqn']
		response: 'outinvoices'

	# X10

	inInvoices:
		path: 'InInvoices'
		request: 'getininvoices'
		order: [
			'getininvoices.wmid', 'getininvoices.wminvid'
			'getininvoices.datestart', 'getininvoices.datefinish', 'reqn'
		]
		response: 'ininvoices'

	# X2

	createPayment:
		path: 'Trans'
		request: 'trans'
		order: [
			'reqn', 'trans.tranid', 'trans.pursesrc', 'trans.pursedest'
			'trans.amount', 'trans.period', 'trans.pcode'
			'trans.desc', 'trans.wminvid'
		]
		response: 'operation'

	# X3

	operations:
		path: 'Operations'
		request: 'getoperations'
		order: ['getoperations.purse', 'reqn']
		response: 'operations'

	# X5

	finishProtect:
		path: 'FinishProtect'
		request: 'finishprotect'
		order: ['finishprotect.wmtranid', 'finishprotect.pcode', 'reqn']
		response: 'operation'

	# X13

	rejectProtect:
		path: 'RejectProtect'
		request: 'rejectprotect'
		order: ['rejectprotect.wmtranid', 'reqn']
		response: 'operation'

	# X14

	TransMoneyback:
		path: 'TransMoneyback'
		request: 'trans'
		order: ['reqn', 'trans.inwmtranid', 'trans.amount']
		response: 'operation'

	# X16

	createPurse:
		path: 'CreatePurse'
		request: 'createpurse'
		order: ['createpurse.wmid', 'createpurse.pursetype', 'reqn']
		response: 'purse'

	# X9

	purses:
		path: 'Purses'
		request: 'getpurses'
		order: ['getpurses.wmid', 'reqn']
		response: 'purses'

	# X8

	FindWMPurseNew:
		request: 'testwmpurse'
		order: ['testwmpurse.wmid', 'testwmpurse.purse']
		response: 'testwmpurse'

	# X6

	sendMessage:
		path: 'SendMsg'
		request: 'message'
		order: [
			'message.receiverwmid', 'reqn'
			'message.msgtext', 'message.msgsubj'
		]
		response: 'message'

	# X15-1

	TrustList:
		request: 'gettrustlist'
		order: ['gettrustlist.wmid', 'reqn']
		response: 'trustlist'

	# X15-2

	TrustList2:
		request: 'gettrustlist'
		order: ['gettrustlist.wmid', 'reqn']
		response: 'trustlist'

	# X15-3

	TrustSave2:
		request: 'trust'
		order: ['wmid', 'trust.purse', 'trust.masterwmid', 'reqn']
		response: 'trust'

# Exported objects

module.exports = W3Interface
