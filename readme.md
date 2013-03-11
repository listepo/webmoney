# WebMoney

_webmoney_ provides you with easy and nice interface in order to access WebMoney payment system.

# API

## Class Service

Description.

## Class ClassicKey

This class provides ability to decode and encode keys for classic authorization.

### ::fromFile(fileName, wmid, password)
- `fileName` String
- `wmid` String
- `password` String

Description.

## Class Purse

Description.

## Class Payment

Description.

### .process(callback)
- `callback` Function
- `return` Payment

Description.

### .reverse(callback)
- `callback` Function
- `return` Payment

Description.

## Class Invoice

Description.

### .pay(callback)
- `callback` Function
- `return` Invoice

Description.

## Class Message

Description.

### .send(callback)
- `callback` Function
- `return` Message

Description.

## Class LazyList

It is an abstract class with some basic features. All other list clases are based on `LazyList`.

### .filter(condition)
- `condition` Array | Object
- `return` LazyList

Selects items which satisfy provided condition.

### .exclude(condition)
- `condition` Array | Object
- `return` LazyList

Excludes items which satisfy provided condition.

### .skip(count)
- `count` Number
- `return` LazyList

Skips pointed number of items.

### .limit(count)
- `count` Number
- `return` LazyList

Limits number of items.

### .fetch(callback)
- `callback` Function
- `return` LazyList

Fetches selected items from the server.

### .exists(callback)
- `callback` Function
- `return` LazyList

Check whether list have at least one item.

## Class PurseList

This class represents a list of purses. No actual actions will occur unless you call `fetch` method.

### ::constructor(condition)
- `condition` Array | Object

Constructor for `PurseList` class.

### .filter(condition)
- `condition` Array | Object

Selects purses which satisfy provided condition.

if `condition` is `Array` it should consists of purse numbers. Otherwise `condition` contains key-value pairs.

Valid keys are:
- `number`
- `owner`
- `type`
- `amount`

### Examples

First of all we will print details about pointed purses:

```coffeescript
purses.filter(number: ['R123456789012', 'Z098765432109'])

purses.fetch((error, data) ->
	unless error? then console.log(data) else console.log(error)
	
	undefined
)
```

Imagine we have some WMID and wish to get all purses belong to them:

```coffeescript
purses.filter(owner: ['123456789012', '132435465768'])

purses.fetch((error, data) ->
	unless error? then console.log(data) else console.log(error)

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
