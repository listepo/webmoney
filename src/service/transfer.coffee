# WebMoney transfer service
#
# August, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported interfaces: A1 - A3, WMC1 - WMC4, ATM1 - ATM2

# WebMoney transfer service

class TransferService
	# Default hosts

	@DEFAULT_HOST: 'transfer.gdcert.com'

	# Parameters for signature generation

	@SIGNATURES:
		prepayment1: [
			'wmid'
			'payment.pspname'
			'payment.pspcode'
			'payment.pspnumber'
			'payment.pspdate'
			'payment.purse'
			'payment.price'
		]
		payment1: [
			'wmid'
			'payment.$id'
			'payment.$test'
			'payment.pspname'
			'payment.pspcode'
			'payment.pspnumber'
			'payment.pspdate'
			'payment.purse'
			'payment.price'
			'payment.cheque'
			'payment.date'
			'payment.kiosk_id'
		]
		history: [
			'wmid'
			'datestart'
			'dateend'
		]
		PrePayment1: [
			'wmid'
			'payment.$currency'
			'payment.purse'
			'payment.phone'
			'payment.price'
		]
		Payment1: [
			'wmid'
			'payment.$id'
			'payment.$currency'
			'payment.$test'
			'payment.purse'
			'payment.phone'
			'payment.price'
			'payment.date'
			'payment.point'
		]
		History1: [
			'wmid'
			'datestart'
			'dateend'
			'wmtranid'
		]
		RetPayment1: [
			'wmid'
			'payment.remark'
			'payment.wmtranid'
		]
		PrePayment2: [
			'wmid'
			'payment.$currency'
			'payment.purse'
			'payment.price'
		]
		Payment2: [
			'wmid'
			'payment.$id'
			'payment.$currency'
			'payment.$test'
			'payment.purse'
			'payment.price'
			'payment.date'
			'payment.point'
		]

# Exported objects

module.exports = TransferService
