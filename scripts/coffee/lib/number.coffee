if typeof define isnt 'function' then define = require('amdefine')(module)

define ->

	number =

		isInt: (n) ->

			return typeof n is 'number' and

				parseFloat(n) is parseInt(n, 10) and not isNaN(n)