mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/jschat'

Schema = mongoose.Schema

AuthS = new Schema
	auth:	String
	nick:	String
	time:	Date
Auth = mongoose.model 'Auth', AuthS

exports.setnick = (auth, nick) ->
	a = new Auth()
	a.auth = auth
	a.nick = nick
	a.time = new Date()
	a.save (err) -> console.log err
