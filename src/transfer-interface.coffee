# WebMoney transfer interface
#
# September, 2013 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Supported methods: A1 - A3, WMC1 - WMC4, ATM1 - ATM2

# Transfer interface

TransferInterface =
	# A1

	prepayment1:
		input:
			container: 'payment'
			order: [
				'wmid', 'payment.pspname', 'payment.pspcode', 'payment.pspnumber'
				'payment.pspdate', 'payment.purse', 'payment.price'
			]
		output: container: 'payment'

	# A2

	payment1:
		input:
			container: 'payment'
			order: [
				'wmid', 'payment.$id', 'payment.$test', 'payment.pspname'
				'payment.pspcode', 'payment.pspnumber', 'payment.pspdate', 'payment.purse'
				'payment.price', 'payment.cheque', 'payment.date', 'payment.kiosk_id'
			]
		output: container: 'payment'

	# A3

	history:
		input: order: ['wmid', 'datestart', 'dateend']
		output: container: 'history'

	# WMC1

	PrePayment1:
		input:
			container: 'payment'
			order: [
				'wmid', 'payment.$currency', 'payment.purse'
				'payment.phone', 'payment.price'
			]
		output: container: 'payment'

	# WMC2

	Payment1:
		input:
			container: 'payment'
			order: [
				'wmid', 'payment.$id', 'payment.$currency', 'payment.$test', 'payment.purse'
				'payment.phone', 'payment.price', 'payment.date', 'payment.point'
			]
		output: container: 'payment'

	# WMC3

	History1:
		input: order: ['wmid', 'datestart', 'dateend', 'wmtranid']
		output: container: 'history'

	# WMC4

	RetPayment1:
		input:
			container: 'payment'
			order: ['wmid', 'payment.remark', 'payment.wmtranid']
		output: container: 'payment'

	# ATM1

	PrePayment2:
		input:
			container: 'payment'
			order: ['wmid', 'payment.$currency', 'payment.purse', 'payment.price']
		output: container: 'payment'

	# ATM2

	Payment2:
		input:
			container: 'payment'
			order: [
				'wmid', 'payment.$id', 'payment.$currency', 'payment.$test'
				'payment.purse', 'payment.price', 'payment.date', 'payment.point'
			]
		output: container: 'payment'

# Exported objects

module.exports = TransferInterface
