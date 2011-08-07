socket = new io.Socket 'http://localhost', {port:81}
socket.on 'news', (data) ->
	console.log data
	socket.emit 'my other event', { my: 'data' }

socket.connect()
