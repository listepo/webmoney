#! /usr/bin/env coffee

WebMoney = require('..')

# Загружаем ключи из файла

key = WebMoney.Key.fromFile('111111111111.kwm', null, '12345')

# Создаем сервис

w3 = new WebMoney.W3(WMID, key)

# Вызываем методы с w3s

w3.operations(null, (error, data) ->
	console.log(error, data)

	undefined
)
