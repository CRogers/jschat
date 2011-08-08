socket = io.connect 'http://localhost', {port:81}
socket.on 'news', (data) ->
	console.log data
	socket.emit 'my other event', { my: 'data' }
