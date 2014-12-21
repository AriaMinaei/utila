module.exports = class Emitter

	constructor: ->

		@_listeners = {}

		@_listenersForAnyEvent = []

		@_emittersToPipeTo = []

		@_emittersSubscribedTo = []

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

	onAnyEvent: (listener) ->

		@_listenersForAnyEvent.push listener

		@

	off: (eventName, listener) ->

		return @ unless @_listeners[eventName]?

		events = @_listeners[eventName]

		index = events.indexOf listener

		events.splice index, 1

		@

	removeListeners: (eventName) ->

		return @ unless @_listeners[eventName]?

		@_listeners[eventName].length = 0

		@

	removeAllListeners: ->

		for name, listeners of @_listeners

			listeners.length = 0

		@

	_emit: (eventName, data) ->

		for emitter in @_emittersToPipeTo

			emitter._emit eventName, data

		for listener in @_listenersForAnyEvent

			listener.call @, data, eventName

		return unless @_listeners[eventName]?

		for listener in @_listeners[eventName]

			listener.call @, data

		return

	pipe: (emitter) ->

		@_emittersToPipeTo.push emitter

		emitter._emittersSubscribedTo.push this

		@

	createPipedEmitter: ->

		(new Emitter).subscribe this

	unpipe: (emitter) ->

		# TODO: we'll obvs have a problem if unpipe is called inside an emitter,
		# but we can skip this for now.

		@_emittersToPipeTo.splice @_emittersToPipeTo.indexOf(emitter), 1

		emitter._emittersSubscribedTo.splice emitter._emittersSubscribedTo.indexOf(this), 1

		@

	subscribe: (emitter) ->

		emitter.pipe this

		@

	unsubscribe: (emitter) ->

		emitter.unpipe this

		@