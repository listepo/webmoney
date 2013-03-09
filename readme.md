# WebMoney

_webmoney_ provides you with easy and nice interface in order to access WebMoney payment system.

## API

### PurseList

This class represents a list of purses.

### OperationList

This class represents a list of operations.

#### filter(condition)
- `condition` Array | Object

Selects items which satisfy provided condition.

#### skip(count)
- `count` Number

Skips pointed number of items.

#### limit(count)
- `count` Number

Limits number of items.

#### fetch(callback)
- `callback` Function

Fetches selected items from the server.
