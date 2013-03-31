module.exports = new class BaseImpl

	connect: (callback) ->
		return callback()

	write: (user, callback) ->
		return callback null, user
