# Classes for dealing with WebMoney
#
# November, 2012 year
#
# Author - Vladimir Andreev
#
# E-Mail: volodya@netfolder.ru

# Exported objects

exports.Classic = require('./lib/classic')
exports.Light = require('./lib/light')
exports.Key = require('./lib/key')

exports.WMID = require('./lib/wmid')

# BaseList descendants

exports.PurseList = require('./lib/purse-list')
exports.OperationList = require('./lib/operation-list')
exports.InvoiceList = require('./lib/invoice-list')