# WebMoney

_webmoney_ provides you with easy and nice interface in order to access WebMoney payment system.

## API

### Class LazyList

Description.

#### skip(count)
- `count` Number

Skips pointed number of items.

#### limit(count)
- `count` Number

Limits number of items.

#### fetch(callback)
- `callback` Function

Fetches selected items from the server.

### Class PurseList

This class represents a list of purses.

#### filter(condition)
- `condition` Object

Selects purses which satisfy provided condition.

### Class OperationList

This class represents a list of operations.

#### filter(condition)
- `condition` Array | Object

Selects operations which satisfy provided condition.

### Class InvoiceList

This class represents a list of invoices.
