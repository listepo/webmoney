# WebMoney w3 service
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported interfaces: X1 - X10, X13 - X16

# Required modules

https = require('https')
iconv = require('iconv-lite')
XML = require('../../../xml-objects').XML
BaseService = require('./base')
Signer = require('../signer')

filters = require('../../../../silentpay/api/src/filter/body-parser')

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

	#

	fieldValue = (object, path) ->
		result = object

		result = result[key] for key in path.split('.')

		result

	#

	signString = (envelope, order) ->
		result = []

		result.push(fieldValue(envelope, path)) for path in order

		result.join('')

	#

	_serialize: (envelope) ->
		charset = 'utf-8'

		body = iconv.encode(XML.stringify(envelope), charset)

		[body, 'Content-Type': 'application/xml; charset=' + charset, 'Content-Length': body.length]

	#

	_parse: (headers, body) ->
		XML.parse(iconv.decode(body, 'utf-8'))

	# Returns URL path for given method

	_pathClassic: (options) -> '/asp/XML' + options.method + '.asp'

	# Returns URL path for given method

	_pathLight: (options) -> '/asp/XML' + options.method + 'Cert.asp'

	#

	_prepareClassic: (options) ->
		content = reqn: 3, wmid: @wmid
		content[options.container] = options.data
		content.sign = @signer.digest(signString(content, options.order))

		'w3s.request': content

	#
	
	_prepareLight: (options) ->
		content = reqn: 2
		content[options.container] = options.data

		'w3s.request': content

	#

	_unprepare: (envelope) ->
		envelope['w3s.response']

	#

	invoke: (method, data, callback) ->
		methodDef = @constructor.METHODS[method]

		envelope = @_prepareClassic(data: data, container: methodDef.container, order: methodDef.order)

		[body, headers] = @_serialize(envelope)

		path = @_pathClassic(method: method)

		request = https.request(host: @host, port: @port, method: 'POST', path: path, headers: headers, rejectUnauthorized: false)

		request.on('response', (response) =>
			filters.concat(response, (error, data) =>
				#console.log response.headers

				console.log @_unprepare(@_parse(response.headers, data))

				undefined
			)
		)

		request.on('error', (error) ->
			# Error handling

			callback?(error)

			undefined
		)

		console.log data
		console.log ''

		request.end(body)

		@

# Exported objects

module.exports = W3Service
