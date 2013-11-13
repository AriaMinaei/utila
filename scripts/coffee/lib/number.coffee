module.exports = number =

	isInt: (n) ->

		return typeof n is 'number' and

			parseFloat(n) is parseInt(n, 10) and not isNaN(n)