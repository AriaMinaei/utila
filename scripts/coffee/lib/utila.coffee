if typeof define isnt 'function' then define = require('amdefine')(module)

define [
	'./array'
	'./classic'
	'./func'
	'./Hash'
	'./number'
	'./object'
	'./path'
], (array, classic, func, Hash, number, object, path) ->

	utila =

		array: array
		classic: classic
		func: func
		Hash: Hash
		number: number
		object: object
		path: path