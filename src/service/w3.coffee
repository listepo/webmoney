# WebMoney w3 service
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported interfaces: X1 - X10, X13 - X16

# WebMoney w3 service

class W3Service
	# Default hosts

	@CLASSIC_HOST: 'w3s.webmoney.ru'	# Host for classic authorization
	@LIGHT_HOST: 'w3s.wmtransfer.com'	# Host for light authorization

	#

	@CONTAINERS:
		Invoice: 'invoice'				# X1
		Trans: 'trans'					# X2
		Operations: 'getoperations'		# X3
		OutInvoices: 'getoutinvoices'	# X4
		FinishProtect: 'finishprotect'	# X5
		SendMsg: 'message'				# X6
		FindWMPurseNew: 'testwmpurse'	# X8
		Purses: 'getpurses'				# X9
		InInvoices: 'getininvoices'		# X10
		RejectProtect: 'rejectprotect'	# X13
		TransMoneyback: 'trans'			# X14
		TrustList: 'gettrustlist'		# X15-1
		TrustList2: 'gettrustlist'		# X15-2
		TrustSave2: 'trust'				# X15-3
		CreatePurse: 'createpurse'		# X16

	# Parameters for signature generation

	@SIGNATURES:
		Invoice: [
			'invoice.orderid'
			'invoice.customerwmid'
			'invoice.storepurse'
			'invoice.amount'
			'invoice.desc'
			'invoice.address'
			'invoice.period'
			'invoice.expiration'
			'reqn'
		]
		Trans: [
			'reqn'
			'trans.tranid'
			'trans.pursesrc'
			'trans.pursedest'
			'trans.amount'
			'trans.period'
			'trans.pcode'
			'trans.desc'
			'trans.wminvid'
		]
		Operations: [
			'getoperations.purse'
			'reqn'
		]
		OutInvoices: [
			'getoutinvoices.purse'
			'reqn'
		]
		FinishProtect: [
			'finishprotect.wmtranid'
			'finishprotect.pcode'
			'reqn'
		]
		SendMsg: [
			'message.receiverwmid'
			'reqn'
			'message.msgtext'
			'message.msgsubj'
		]
		FindWMPurseNew: [
			'testwmpurse.wmid'
			'testwmpurse.purse'
		]
		Purses: [
			'getpurses.wmid'
			'reqn'
		]
		InInvoices: [
			'getininvoices.wmid'
			'getininvoices.wminvid'
			'getininvoices.datestart'
			'getininvoices.datefinish'
			'reqn'
		]
		RejectProtect: [
			'rejectprotect.wmtranid'
			'reqn'
		]
		TransMoneyback: [
			'reqn'
			'trans.inwmtranid'
			'trans.amount'
		]
		TrustList: [
			'gettrustlist.wmid'
			'reqn'
		]
		TrustList2: [
			'gettrustlist.wmid'
			'reqn'
		]
		TrustSave2: [
			'wmid'
			'trust.purse'
			'trust.masterwmid'
			'reqn'
		]
		CreatePurse: [
			'createpurse.wmid'
			'createpurse.pursetype'
			'reqn'
		]

	# Returns URL path for given method

	_path: (options) -> '/asp/XML' + options.method + '.asp'

	# Returns URL path for given method

	_path: (options) -> '/asp/XML' + options.method + 'Cert.asp'

	#

	_prepare: (options) ->
		envelope = reqn: 1, wmid: @wmid, sign: '12345'
		envelope['test'] = options.data

		'w3s.request': envelope

	#
	
	_prepare: (options) ->
		envelope = reqn: @reqn()
		envelope['test'] = options.data

		'w3s.request': envelope

# Exported objects

module.exports = W3Service
