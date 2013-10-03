_common = require './_common'

module.exports = object =

	isBareObject: _common.isBareObject.bind _common

	###
	if 'what' is an object, but an instance of some class,
	like: what = new Question
	object.isInstance what # yes
	###
	isInstance: (what) ->

		not @isBareObject what

	###
	Alias to _common.typeOf
	###
	typeOf: _common.typeOf.bind _common

	###
	Alias to _common.clone
	###
	clone: _common.clone.bind _common

	###
	Empties an object of its properties.
	###
	empty: (o) ->

		for prop of o

			delete o[prop] if o.hasOwnProperty prop

		o

	###
	Empties an o. Doesn't check for hasOwnProperty, so it's a tiny
	bit faster. Use it for plain objects.
	###
	fastEmpty: (o) ->

		delete o[property] for property of o

		o

	###
	if 'from' holds a set of default values,
	the values in 'to' will be overriden onto them, as long as
	they're not undefined.
	###
	overrideOnto: (onto, toOverride) ->

		return onto if not @isBareObject(toOverride) or not @isBareObject(onto)

		for key, oldVal of onto

			newVal = toOverride[key]

			continue if newVal is undefined

			if typeof newVal isnt 'object' or @isInstance newVal

				onto[key] = @clone newVal

			# newVal is a plain object
			else

				if typeof oldVal isnt 'object' or @isInstance oldVal

					onto[key] = @clone newVal

				else

					@overrideOnto oldVal, newVal
		onto

	###
	Takes a clone of 'from' and runs #overrideOnto on it
	###
	override: (onto, toOverride) ->

		@overrideOnto @clone(onto), toOverride

	append: (onto, toAppend) ->

		@appendOnto @clone(onto), toAppend

	appendOnto: (onto, toAppend) ->

		return onto if not @isBareObject(toAppend) or not @isBareObject(onto)

		for key, newVal of toAppend

			continue unless newVal isnt undefined and toAppend.hasOwnProperty key

			if typeof newVal isnt 'object' or @isInstance newVal

				onto[key] = newVal

			else

				# newVal is a bare object

				oldVal = onto[key]

				if typeof oldVal isnt 'object' or @isInstance oldVal

					onto[key] = @clone newVal

				else

					@appendOnto oldVal, newVal

	groupProps: (obj, groups) ->

		grouped = {}

		for name, defs of groups

			grouped[name] = {}

		grouped['rest'] = {}

		`top: //`
		for key, val of obj

			shouldAdd = no

			for name, defs of groups

				unless Array.isArray defs

					defs = [defs]

				for def in defs

					if typeof def is 'string'

						if key is def

							shouldAdd = yes

					else if def instanceof RegExp

						if def.test key

							shouldAdd = yes

					else if def instanceof Function

						if def key

							shouldAdd = yes

					else

						throw Error 'Group definitions must either
						be strings, regexes, or functions.'

					if shouldAdd

						grouped[name][key] = val

						`continue top`

			grouped['rest'][key] = val

		grouped