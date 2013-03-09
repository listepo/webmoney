# WebMoney

_webmoney_ provides you with easy and nice interface in order to access WebMoney payment system.

# Query Language

# API

## Class Service

## Class ClassicKey

This class provides ability to decode and encode keys for classic authorization.

## Class LazyList

It is an abstract class with some basic features.

### list.skip(count)
- `count` Number

Skips pointed number of items.

### list.limit(count)
- `count` Number

Limits number of items.

### list.fetch(callback)
- `callback` Function

Fetches selected items from the server.

## Class PurseList

This class represents a list of purses.

### list.filter(condition)
- `condition` Object

Selects purses which satisfy provided condition.

`condition` contains key-value pairs.

Valid keys are:
- `wmid`

## Class OperationList

This class represents a list of operations.

### list.filter(condition)
- `condition` Array | Object

Selects operations which satisfy provided condition.

if `condition` is `Array` it should consists of operation IDs. Otherwise `condition` contains key-value pairs.

Valid keys are:
- `purse`
- `operation`
- `transfer`
- `invoice`
- `order`
- `date`

## Class InvoiceList

This class represents a list of invoices.

### list.filter(condition)
- `condition` Array | Object

Selects invoices which satisfy provided condition.
