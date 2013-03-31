#!/usr/bin/env coffee

http = require 'http'
crypto = require 'crypto'

async = require 'async'

increment = Math.floor Math.random() * 32767

uuid = ->
	if increment++ >= 32767 then increment = 0
	seconds = Math.round(new Date().getTime() / 1000.0)
	buffer = new Buffer(12)
	buffer.writeUInt32BE(seconds, 0)
	buffer.writeUInt16BE(increment, 10)
	crypto.randomBytes(6).copy(buffer, 4)
	return buffer.toString('hex')

names = ['alice', 'joe', 'bob', 'sam', 'steph', 'ryan', 'paul', 'cecil', 'sorrel', 'james']
nextName = 0
nextAge = 0

i = 0

db = require("./#{process.argv[2]}Impl")

db.connect (err) ->
	if err
		console.log 'error connecting to db', err
		return process.exit 1

	server = http.createServer (req, res) ->
		
		name = names[nextName++%names.length]
		id = uuid()
		user = {
			_id: id
			name: name
			age: nextAge++%30
			email: "#{name}@#{id}"
		}

		db.write user, (err, user) ->
			if err
				console.log "************ write error", err
				res.writeHead 500
				return res.end()
			res.writeHead 200, err
			res.end JSON.stringify(user)+"\n"


	server.listen 8080, '0.0.0.0', ->
		console.log 'listening on 8080'
