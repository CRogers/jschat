mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/jschat'

Schema = mongoose.Schema

AuthS = new Schema
	auth:	{type: String, unique: true}
	nick:	String
	time:	Date
Auth = mongoose.model 'Auth', AuthS

exports.setnick = (auth, nick) ->
	a = new Auth()
	a.auth = auth
	a.nick = nick
	a.time = new Date()
	a.save (err) -> console.log err

exports.getnick = (auth, callback) ->
	console.log "db.getnick #{auth}"
	Auth.findOne {auth: auth}, (auth) -> console.log auth
