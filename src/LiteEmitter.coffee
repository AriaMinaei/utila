module.exports = class Emitter

	constructor: ->

		@_listeners = {}

	on: (eventName, listener) ->

		unless @_listeners[eventName]?

			@_listeners[eventName] = []

		@_listeners[eventName].push listener

		@

	once: (eventName, listener) ->

		ran = no

		cb = =>

			return if ran

			ran = yes

			do listener

			setTimeout =>

				@off eventName, cb

			, 0

		@on eventName, cb

		@

	off: (eventName, listener) ->

		return @ unless @_listeners[eventName]?

		@_listeners[eventName].splice @_listeners[eventName].indexOf(listener), 1

		@

	_emit: (eventName, data) ->

		return unless @_listeners[eventName]?

		for listener in @_listeners[eventName]

			listener.call @, data

		return