db = require './db'

io = require('socket.io').listen 81

io.sockets.on 'connection', (socket) ->	
	socket.on 'auth.send', (auth) ->
		db.nick.get auth, (nick) -> socket.emit 'nick.get', nick
	
	socket.on 'auth.req', ->
		auth = guid()
		db.nick.new auth, 'noname'
		socket.emit 'auth.get', auth
		socket.emit 'nick.get', 'noname'
	
	socket.on 'nick.set', (data) ->
		console.log data
		db.nick.set data.auth, data.data, -> 
			db.nick.get data.auth, (nick) -> 
				socket.emit 'nick.get', nick
		
guid = ->
	S4 = -> 
		(((1+Math.random())*0x10000)|0).toString(16).substring(1)
	S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4()
