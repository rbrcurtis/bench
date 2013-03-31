module.exports = new class BaseImpl

	connect: (callback) ->
		require('couchbase').connect {hosts:['localhost:8091'], bucket:"default"}, (err, @cb) =>
			return callback err

	write: (user, callback) ->
		@cb.set user._id, user, callback
