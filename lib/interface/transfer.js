// Generated by CoffeeScript 1.6.3
var TransferInterface;

TransferInterface = {
  prepayment1: {
    container: 'payment',
    order: ['wmid', 'payment.pspname', 'payment.pspcode', 'payment.pspnumber', 'payment.pspdate', 'payment.purse', 'payment.price']
  },
  payment1: {
    container: 'payment',
    order: ['wmid', 'payment.$id', 'payment.$test', 'payment.pspname', 'payment.pspcode', 'payment.pspnumber', 'payment.pspdate', 'payment.purse', 'payment.price', 'payment.cheque', 'payment.date', 'payment.kiosk_id']
  },
  history: {
    order: ['wmid', 'datestart', 'dateend']
  },
  PrePayment1: {
    container: 'payment',
    order: ['wmid', 'payment.$currency', 'payment.purse', 'payment.phone', 'payment.price']
  },
  Payment1: {
    container: 'payment',
    order: ['wmid', 'payment.$id', 'payment.$currency', 'payment.$test', 'payment.purse', 'payment.phone', 'payment.price', 'payment.date', 'payment.point']
  },
  History1: {
    order: ['wmid', 'datestart', 'dateend', 'wmtranid']
  },
  RetPayment1: {
    order: ['wmid', 'payment.remark', 'payment.wmtranid']
  },
  PrePayment2: {
    container: 'payment',
    order: ['wmid', 'payment.$currency', 'payment.purse', 'payment.price']
  },
  Payment2: {
    container: 'payment',
    order: ['wmid', 'payment.$id', 'payment.$currency', 'payment.$test', 'payment.purse', 'payment.price', 'payment.date', 'payment.point']
  }
};

module.exports = TransferInterface;