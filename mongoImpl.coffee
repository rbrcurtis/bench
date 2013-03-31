{ObjectID, Db, Server} = require 'mongodb'

module.exports = new class MongoImpl

	connect: (callback) ->
		client = new Db("test", new Server("mut8ed.com", 27017, {}), w: 1)
		
		client.open (err) =>
			if err
				return callback err
			
			client.collection "test", (err, @collection) =>

				return callback err


	write: (user, callback) ->
		user._id = new ObjectID user._id
		@collection.insert user, callback
