# WebMoney

_webmoney_ provides you with easy and nice interface in order to access WebMoney payment system.

# Query Language

# API

## Class Service

## Class ClassicKey

This class provides ability to decode and encode keys for classic authorization.

## Class LazyList

It is an abstract class with some basic features. All other list clases are based on `LazyList`.

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

This class represents a list of purses. No actual actions will occur unless you call `fetch` method.

### list.filter(condition)
- `condition` Object

Selects purses which satisfy provided condition.

Valid keys for `condition` object are:
- `wmid`
- `type`
- `amount`

### Examples

Imagine we have some WMID and wish to get all purses belong to them.

```coffeescript
purses.filter(wmid: ['123456789012', '132435465768'])

purses.fetch((error, data) ->
	unless error? then console.log(data) else console.log(error)

	undefined
)
```

Look great! Go deeper. Sometimes it's useful to filter purses of some currency.

```coffeescript
purses.filter(wmid: ['123456789012', '132435465768'], type: ['Z', 'R'])

purses.fetch((error, data) ->
	unless error?
		if data.length then console.log(data) else console.log('Sorry! No USD or RUR purses found')
	else
		console.log(error)

	undefined
)
```

But stop! Maybe you purses is out of money? Let's check it!

```coffeescript
purses.filter(wmid: ['123456789012', '132435465768'], type: 'Z', amount: $le: 100)

purses.fetch((error, data) ->
	unless error?
		if data.length then console.log(data) else console.log('You have at least 100$')
	else
		console.log(error)

	undefined
)
```

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

### Examples

Let's get operations for some purses and print first 5 of them

```coffeescript
operations.filter(purse: ['R123456789012', 'Z987654321098']).limit(5)

operations.fetch((error, data) ->
	unless error? then console.log(data) else console.log(error)
	
	undefined
)
```

## Class InvoiceList

This class represents a list of invoices.

### list.filter(condition)
- `condition` Array | Object

Selects invoices which satisfy provided condition.
