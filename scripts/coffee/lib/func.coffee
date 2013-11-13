if typeof define isnt 'function' then define = require('amdefine')(module)

define ->

	func =

		throttle: (func, time = 1000) ->

			lastCalled = 0

			return ->

				now = Date.now()

				if now - lastCalled < time

					return

				lastCalled = now

				func.apply null, arguments