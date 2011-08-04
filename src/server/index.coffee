io = require('socket.io').listen 81

io.sockets.on 'connection', (socket) ->
	socket.on 'set nick', (name) ->
		socket.set 'nick', name, ->
			socket.emit 'ready'
	
	socket.on 'msg', ->
		socket.get 'nickname', (name) ->
			console.log 'Chat messaged by', name
