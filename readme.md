# WebMoney

_webmoney_ provides you with easy and nice interface in order to access WebMoney payment system.

# Low-Level API

## Class Service

Description.

## Class ClassicKey

This class provides ability to decode and encode keys for classic authorization.

### ::fromFile(fileName, wmid, password)
- `fileName` String
- `wmid` String
- `password` String

Description.

### ::fromBuffer()

Description.

### .toFile(fileName)

Description.

# High-Level API

## Class Model

Description.

### ::constructor(data)
- `data` Object

Description.

### .isNew()
- `return` Boolean

Check whether model has been saved.

## Class Purse

Description.

## Class Operation

This class represents an operation.

### .process(callback)
- `callback` Function
- `return` Operation

Processes payment and calls `callback` on complete.
Data received from the server will be cached so that payment state will remain actual.
This method returns original `this` object.

Note you can use this method only with newly created payments.

### .finish(code, callback)
- `code` String
- `callback` Function
- `return` Operation

Finishes protected operation by supplying provided code and calls `callback` on complete.
This method returns original `this` object.

### .reject(callback)
- `callback` Function
- `return` Operation

Rejects protected operations.
This method returns original `this` object.

### .reverse(amount, callback)
- `amount` Number
- `callback` Function
- `return` Operation

Refunds money to the sender and calls `callback` on complete.
Data received from the server will be cached so that payment state will remain actual.

Note you can call this method many times on the same payment untill all sum will be refunded.

### Examples

```coffeescript
payment = new webmoney.Operation(
	pursesrc: 'R123456789012'
	pursedest: 'R098765432109'
	amount: 150
	onlyauth: 1
)

payment.process((error) ->
	unless error? then console.log('Successfully done!') else console.log(error)
	
	undefined
)
```

```coffeescript
deposition = new webmoney.Operation(
	wmtranid: 12385309875
)

deposition.finish('my code', (error) ->
	unless error? then console.log('Deposition accepted!') else console.log(error)
	
	undefined
)
```

## Class Invoice

This class represents an invoice.

### .save(callback)
- `callback` Function
- `return` Invoice

Saves invoice to the server

### .pay(callback)
- `callback` Function
- `return` Invoice

Description.

## Class Message

This class represents a message.

### .send(callback)
- `callback` Function
- `return` Message

Description.

### Examples

```coffeescript
message = new webmoney.Message(
	destination: '123456789012'
	subject: 'Hello'
	body: 'I have some good ideas!'
)

message.send((error) ->
	console.log(error)
	
	undefined
)
```

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
