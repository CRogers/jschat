db = require './db'

io = require('socket.io').listen 81

io.sockets.on 'connection', (socket) ->
	console.log 'hi'
	
	socket.on 'sendauth', (auth) ->
		db.getnick auth, (nick) -> socket.emit 'getnick', nick
	
	socket.on 'reqauth', ->
		auth = guid()
		db.setnick auth, 'noname'
		socket.emit 'getauth', auth
		db.getnick auth, (nick) -> 
			console.log 'hi'
			socket.emit 'getnick', nick
	
	socket.on 'nick', (data) ->
		console.log data
		db.setnick data.auth, data.data
		
guid = ->
	S4 = -> 
		(((1+Math.random())*0x10000)|0).toString(16).substring(1)
	S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4()
