path = require 'path'

module.exports = pathTools =

	compare: (a, b) ->

		aComps = @_getComponents a
		bComps = @_getComponents b

		ancestorPath = []
		a2Ancestor = []
		b2Ancestor = []
		ancestor2A = []
		ancestor2B = []

		for part, i in aComps

			break if part isnt bComps[i]

			ancestorPath.push part

		for i in [ancestorPath.length..aComps.length - 1]

			if i < aComps.length - 1

				a2Ancestor.push '..'

			ancestor2A.push aComps[i]

		for i in [ancestorPath.length..bComps.length - 1]

			if i < bComps.length - 1

				b2Ancestor.push '..'

			ancestor2B.push bComps[i]

		ret =

			commonAncestor: @_fromArray ancestorPath

			a2Ancestor: @_fromArray a2Ancestor
			b2Ancestor: @_fromArray b2Ancestor
			ancestor2A: @_fromArray ancestor2A
			ancestor2B: @_fromArray ancestor2B

	_getComponents: (p) ->

		p = p.split('\\').join('/').split('/')

	_getCommonAncestor: (a, b) ->

		soFar = []

		for part, i in a

			if part is b[i]

				soFar.push part

			else

				break

		soFar

	_fromArray: (a) ->

		a.join '/'

	slashesOnly: (p) ->

		p.split('\\').join('/')

	replaceExtension: (file, newExt) ->

		ext = path.extname file

		return file.substr(0, file.length - ext.length) + '.' + newExt