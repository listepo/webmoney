# WebMoney merchant service
#
# September, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Required modules

BaseService = require('./base')
Signer = require('../signer')

#

class MerchantEnvelope1
	#

	@CLASSIC_HOST: 'merchant.webmoney.ru'	# Host for classic authorization
	@LIGHT_HOST: 'merchant.wmtransfer.com'	# Host for light authorization

	#

	_prepare: (options) ->
		content = wmid: @wmid
		extend(content, options.data)

		content.sign = '12345'
		#content.secret_key = '12345'
		#content.md5 = '12345'

		'merchant.request': content

#

class MerchantEnvelope2
	# Default host for requests

	@DEFAULT_HOST: 'merchant.webmoney.ru'

	#

	_prepare: (options) ->
		content = signtags: wmid: @wmid
		content[options.container] = options.data

		content.signtags.sign = '12345'
		#content.signtags.secret_key = '12345'
		#content.signtags.md5 = '12345'

		'merchant.request': content

# Merchant service

class MerchantService extends BaseService
	# Default hosts for requests

	

	# Object constructor

	constructor: (host, port) ->
		super(host, port)

	# Returns URL path for given method

	_path: (options) -> '/conf/xml/XML' + options.method + '.asp'

# Exported objects

module.exports = MerchantService
