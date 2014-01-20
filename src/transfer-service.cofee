# WebMoney transfer service
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported interfaces: A1 - A3, WMC1 - WMC4, ATM1 - ATM2

# Required modules

BaseService = require('./base')

#

SIGN_CLASSIC = 1
SIGN_LIGHT = 2

# WebMoney transfer service

class TransferService extends BaseService
	# Default host for requests

	@DEFAULT_HOST: 'transfer.gdcert.com'

	#

	_prepare: (options) ->
		content = wmid: @wmid
		content[options.container] = options.data

		content.sign = $type: SIGN_CLASSIC, $: text: @signer.digest(@_signString(content, options.order))

		'w3s.request': content

# Exported objects

module.exports = TransferService
