require './_prepare'

spec ['path'], (path) ->

	test 'compare', ->

		c = path.compare 'a/b/c/d.coffee', 'a/b/c2/d2/e2.js'

		c.commonAncestor.should.equal 'a/b'
		c.a2Ancestor.should.equal '..'
		c.b2Ancestor.should.equal '../..'
		c.ancestor2A.should.equal 'c/d.coffee'
		c.ancestor2B.should.equal 'c2/d2/e2.js'