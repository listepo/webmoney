# WebMoney

Easy and lightweight client for WebMoney payment system.

## Features

- Supports both classic and light authorization

## Installation

```
$ npm install webmoney
```

## API

### Class Key

This class provides ability to decode and encode keys for classic authorization.

#### ::fromFile(fileName, wmid, password)
- `fileName` String
- `wmid` String
- `password` String

Description.

#### ::fromBuffer(header, body, wmid, password)
- `header` Buffer
- `body` Buffer
- `wmid` String
- `password` String

Description.

#### ::constructor(exponent, modulus)
- `exponent` Buffer
- `modulus` Buffer

Description.

#### .exponent

Exponent component of the key.

#### .modulus

Modulus component of the key.

### Class Signer

Description.

#### ::constructor(key)
- `key` Key

Description.

#### .digest(message)

Description.
