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
		name: 'Invoice'
		input:
			container: 'invoice'
			order: [
				'invoice.orderid', 'invoice.customerwmid', 'invoice.storepurse'
				'invoice.amount', 'invoice.desc', 'invoice.address'
				'invoice.period', 'invoice.expiration', 'reqn'
			]
		output: container: 'invoice'

	# X4

	outInvoices:
		name: 'OutInvoices'
		input:
			container: 'getoutinvoices'
			order: ['getoutinvoices.purse', 'reqn']
		output: container: 'outinvoices'

	# X10

	inInvoices:
		name: 'InInvoices'
		input:
			container: 'getininvoices'
			order: [
				'getininvoices.wmid', 'getininvoices.wminvid'
				'getininvoices.datestart', 'getininvoices.datefinish', 'reqn'
			]
		output: container: 'ininvoices'

	# X2

	createOperation:
		name: 'Trans'
		input:
			container: 'trans'
			order: [
				'reqn', 'trans.tranid', 'trans.pursesrc', 'trans.pursedest'
				'trans.amount', 'trans.period', 'trans.pcode'
				'trans.desc', 'trans.wminvid'
			]
		output: container: 'operation'

	# X5

	finishOperation:
		name: 'FinishProtect'
		input:
			container: 'finishprotect'
			order: ['finishprotect.wmtranid', 'finishprotect.pcode', 'reqn']
		output: container: 'operation'

	# X13

	rejectOperation:
		name: 'RejectProtect'
		input:
			container: 'rejectprotect'
			order: ['rejectprotect.wmtranid', 'reqn']
		output: container: 'operation'

	# X14

	reverseOperation:
		name: 'TransMoneyback'
		input:
			container: 'trans'
			order: ['reqn', 'trans.inwmtranid', 'trans.amount']
		output: container: 'operation'

	# X3

	operations:
		name: 'Operations'
		input:
			container: 'getoperations'
			order: ['getoperations.purse', 'reqn']
		output: container: 'operations'

	# X16

	createPurse:
		name: 'CreatePurse'
		input:
			container: 'createpurse'
			order: ['createpurse.wmid', 'createpurse.pursetype', 'reqn']
		output: container: 'purse'

	# X8

	testPurse:
		name: 'FindWMPurseNew'
		input:
			container: 'testwmpurse'
			order: ['testwmpurse.wmid', 'testwmpurse.purse']
		output: container: 'testwmpurse'

	# X9

	purses:
		name: 'Purses'
		input:
			container: 'getpurses'
			order: ['getpurses.wmid', 'reqn']
		output: container: 'purses'

	# X6

	sendMessage:
		name: 'SendMsg'
		input:
			container: 'message'
			order: [
				'message.receiverwmid', 'reqn'
				'message.msgtext', 'message.msgsubj'
			]
		output: container: 'message'

	# X15-1

	TrustList:
		name: 'TrustList'
		input:
			container: 'gettrustlist'
			order: ['gettrustlist.wmid', 'reqn']
		output: container: 'trustlist'

	# X15-2

	TrustList2:
		name: 'TrustList2'
		input:
			container: 'gettrustlist'
			order: ['gettrustlist.wmid', 'reqn']
		output: container: 'trustlist'

	# X15-3

	TrustSave2:
		name: 'TrustSave2'
		input:
			container: 'trust'
			order: ['wmid', 'trust.purse', 'trust.masterwmid', 'reqn']
		output: container: 'trust'

# Exported objects

module.exports = W3Interface
