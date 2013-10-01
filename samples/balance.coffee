#! /usr/bin/env coffee

Key = require('../src/key')
W3Service = require('../src/service/w3')

WMID = '111111111111'

# Загружаем ключи из файла

key = Key.fromFile('111111111111.kwm', WMID, '12345')

# Создаем сервис

w3s = new W3Service(WMID, key)

# Вызываем методы с w3s

data1 = purse: 'R123456789012', datestart: '20120305 20:00:00', datefinish: '20120507 21:00:00'

data2 = receiverwmid: '111111111111', msgsubj: 'Test', msgtext: 'Hello!', onlyauth: 0

w3s.invoke('Operations', data1, (error, data) ->
	console.log(error, data)

	undefined
)
