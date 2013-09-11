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

# WebMoney transfer service

class TransferService extends BaseService
	# Default host for requests

	@DEFAULT_HOST: 'transfer.gdcert.com'

	# Method definitions

	@METHODS:
		prepayment1:
			container: 'payment'
			order: [
				'wmid'
				'payment.pspname'
				'payment.pspcode'
				'payment.pspnumber'
				'payment.pspdate'
				'payment.purse'
				'payment.price'
			]
		payment1:
			container: 'payment'
			order: [
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
		history:
			order: ['wmid', 'datestart', 'dateend']
		PrePayment1:
			container: 'payment'
			order: [
				'wmid'
				'payment.$currency'
				'payment.purse'
				'payment.phone'
				'payment.price'
			]
		Payment1:
			container: 'payment'
			order: [
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
		History1:
			order: ['wmid', 'datestart', 'dateend', 'wmtranid']
		RetPayment1:
			order: ['wmid', 'payment.remark', 'payment.wmtranid']
		PrePayment2:
			container: 'payment'
			order: [
				'wmid'
				'payment.$currency'
				'payment.purse'
				'payment.price'
			]
		Payment2:
			container: 'payment'
			order: [
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
