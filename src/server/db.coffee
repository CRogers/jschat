mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/jschat'

Schema = mongoose.Schema

Auth = mongoose.model 'Auth', new Schema
	auth:		{type: String, index: {unique: true, dropDups: true}}
	nick:		String
	modified:	Date

exports.authexists = (auth) ->
	Auth.count


exports.nick =
	new: 	(auth, nick) ->
				a = new Auth()
				a.auth = auth
				a.nick = nick
				a.modified = new Date()
				console.log "nick.new  #{auth} #{nick}"
				a.save (err) -> console.log err
	
	get:	(auth, callback) ->
				console.log "nick.get #{auth}"
				Auth.findOne {auth: auth}, (err, auth) -> callback auth.nick
		
	set:	(auth, nick, callback) ->
				console.log "nick.set #{auth} #{nick}"
				Auth.update {auth: auth}, {nick: nick, modified: new Date()}, callback
