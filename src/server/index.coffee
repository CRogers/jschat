io = require('socket.io').listen 81

io.sockets.on 'connection', (socket) ->
	console.log 'hi'
	socket.emit 'news', { hello: 'world' }
	socket.on 'my other event', (data) ->
		console.log data
