array = require './array'

module.exports = class Hash

	constructor: ->

		# Knows which index is this name stored in
		@_indexes = {}

		# The simple key/value pair
		@_pairs = {}

		# The plain array that holds all the values
		@array = []

		# Number of elements
		@_len = 0

	getIndexOf: (name) ->

		@_indexes[name]

	set: (name, value) ->

		if @_indexes[name] is undefined

			@_pairs[name] = value
			@array.push value

			index = @array.length - 1

			@_indexes[name] = index

			@_len++

		else

			@_pairs[name] = value

			@array[@_indexes[name]] = value


		@

	get: (name) ->

		@_pairs[name]

	has: (name) ->

		typeof @_pairs[name] isnt 'undefined'

	each: (func, i = null, ascending = yes) ->

		if ascending

			i ?= 0

			loop

				break if i >= @_len

				func @array[i], i

				i++

		else

			i ?= @array.length - 1

			loop

				break if i < 0

				func @array[i], i

				i--

		null

	remove: (name) ->

		return @ if @_indexes[name] is undefined

		@_len--

		@_pairs[name] = undefined

		index = @_indexes[name]

		array.pluck @array, index

		@_indexes[name] = undefined

		for name, value of @_indexes

			continue if value is undefined

			if value > index

				@_indexes[name] = value - 1

		@