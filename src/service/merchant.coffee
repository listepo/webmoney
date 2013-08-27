# WebMoney merchant service
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported interfaces: X18, X20 - X22

# WebMoney merchant service

class MerchantService
	# Default hosts

	@MAIN_HOST: 'merchant.webmoney.ru'		# Host for all types of authorization except light one
	@LIGHT_HOST: 'merchant.wmtransfer.com'	# Host for light authorization

	#

	@CONTAINERS:
		TransGet:
			sign: true
			md5: true
			secret: true
		TransRequest:
			sign: true
			md5: true
			secret: true
			json: true
		TransConfirm:
			sign: true
			md5: true
			secret: true
			json: true
		TrustRequest:
			sign: true
			light: true
		TrustConfirm:
			sign: true
			light: true
		TransSave:
			sign: true
			md5: true
			secret: true

	# Parameters for signature generation

	@SIGNATURES:
		TransGet: [
			'wmid'
			'lmi_payee_purse'
			'lmi_payment_no'
		]
		TransRequest: [
			'wmid'
			'lmi_payee_purse'
			'lmi_payment_no'
			'lmi_clientnumber'
			'lmi_clientnumber_type'
		]
		TransConfirm: [
			'wmid'
			'lmi_payee_purse'
			'lmi_wminvoiceid'
			'lmi_clientnumber_code'
		]
		TrustRequest: [
			'wmid'
			'lmi_payee_purse'
			'lmi_clientnumber'
			'lmi_clientnumber_type'
			'lmi_sms_type'
		]
		TrustConfirm: [
			'wmid'
			'lmi_purseid'
			'lmi_clientnumber_code'
		]
		TransSave: [
			'wmid'
			'lmi_payee_purse'
			'lmi_payment_no'
			'validityperiodinhours'
		]

	#

	constructor: (host, port, cred) ->

	# Returns URL path for given method

	_path: (options) -> '/conf/xml/XML' + options.method + '.asp'

	#

	_prepare: (options) ->
		envelope = wmid: @wmid, sign: '12345'
		extend(envelope, options.data)

		'merchant.request': envelope

	#

	_prepare: (options) ->
		envelope =
			signtags: wmid: @wmid, sign: '12345'
			paymenttags: options.data

		'merchant.request': envelope

# Exported objects

module.exports = MerchantService
