# WebMoney merchant interface
#
# September, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported methods: X18, X20 - X22

# Merchant interface

MerchantInterface =
	#

	TransGet:
		sign: true
		md5: true
		secret: true
		order: ['wmid', 'lmi_payee_purse', 'lmi_payment_no']

	#

	TransRequest:
		sign: true
		md5: true
		secret: true
		json: true
		order: [
			'wmid', 'lmi_payee_purse', 'lmi_payment_no'
			'lmi_clientnumber', 'lmi_clientnumber_type'
		]

	#

	TransConfirm:
		sign: true
		md5: true
		secret: true
		json: true
		order: [
			'wmid', 'lmi_payee_purse'
			'lmi_wminvoiceid', 'lmi_clientnumber_code'
		]

	#

	TrustRequest:
		sign: true
		light: true
		order: [
			'wmid', 'lmi_payee_purse', 'lmi_clientnumber'
			'lmi_clientnumber_type', 'lmi_sms_type'
		]

	#

	TrustConfirm:
		sign: true
		light: true
		order: ['wmid', 'lmi_purseid', 'lmi_clientnumber_code']

	#

	TransSave:
		sign: true
		md5: true
		secret: true
		container: 'paymenttags'
		order: [
			'wmid', 'lmi_payee_purse'
			'lmi_payment_no', 'validityperiodinhours'
		]

# Exported objects

module.exports = MerchantInterface
