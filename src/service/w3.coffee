# WebMoney w3 service
#
# September, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported interfaces: X1 - X10, X13 - X16

# Required modules

BaseService = require('./base')
Signer = require('../signer')

# WebMoney w3 service

class W3Service extends BaseService
	# Default hosts for requests

	@CLASSIC_HOST: 'w3s.webmoney.ru'	# Host for classic authorization
	@LIGHT_HOST: 'w3s.wmtransfer.com'	# Host for light authorization

	# Method definitions

	@METHODS:
		Invoice:
			container: 'invoice'
			order: [
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
		Trans:
			container: 'trans'
			order: [
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
		Operations:
			container: 'getoperations'
			order: [
				'getoperations.purse'
				'reqn'
			]
		OutInvoices:
			container: 'getoutinvoices'
			order: [
				'getoutinvoices.purse'
				'reqn'
			]
		FinishProtect:
			container: 'finishprotect'
			order: [
				'finishprotect.wmtranid'
				'finishprotect.pcode'
				'reqn'
			]
		SendMsg:
			container: 'message'
			order: [
				'message.receiverwmid'
				'reqn'
				'message.msgtext'
				'message.msgsubj'
			]
		FindWMPurseNew:
			container: 'testwmpurse'
			order: [
				'testwmpurse.wmid'
				'testwmpurse.purse'
			]
		Purses:
			container: 'getpurses'
			order: [
				'getpurses.wmid'
				'reqn'
			]
		InInvoices:
			container: 'getininvoices'
			order: [
				'getininvoices.wmid'
				'getininvoices.wminvid'
				'getininvoices.datestart'
				'getininvoices.datefinish'
				'reqn'
			]
		RejectProtect:
			container: 'rejectprotect'
			order: [
				'rejectprotect.wmtranid'
				'reqn'
			]
		TransMoneyback:
			container: 'trans'
			order: [
				'reqn'
				'trans.inwmtranid'
				'trans.amount'
			]
		TrustList:
			container: 'gettrustlist'
			order: [
				'gettrustlist.wmid'
				'reqn'
			]
		TrustList2:
			container: 'gettrustlist'
			order: [
				'gettrustlist.wmid'
				'reqn'
			]
		TrustSave2:
			container: 'trust'
			order: [
				'wmid'
				'trust.purse'
				'trust.masterwmid'
				'reqn'
			]
		CreatePurse:
			container: 'createpurse'
			order: [
				'createpurse.wmid'
				'createpurse.pursetype'
				'reqn'
			]

	#

	constructor: (@wmid, @key, @host = @constructor.CLASSIC_HOST, @port = @constructor.DEFAULT_PORT) ->
		@signer = new Signer(@key)

	# Returns URL path for given method

	_pathClassic: (options) -> '/asp/XML' + options.method + '.asp'

	# Returns URL path for given method

	_pathLight: (options) -> '/asp/XML' + options.method + 'Cert.asp'

	#

	_prepareClassic: (options) ->
		content = reqn: 3, wmid: @wmid
		content[options.container] = options.data
		content.sign = @signer.digest(@_signString(content, options.order))

		'w3s.request': content

	#
	
	_prepareLight: (options) ->
		content = reqn: 2
		content[options.container] = options.data

		'w3s.request': content

	#

	_unprepare: (envelope) ->
		envelope['w3s.response']

# Exported objects

module.exports = W3Service
