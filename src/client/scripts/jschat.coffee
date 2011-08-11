auth = ''
nick = ''



socket = io.connect 'http://localhost', {port:81}

socket.on 'connect', ->
	console.log 'connected'
	cookie = $.cookie 'auth'
	if cookie != null
		console.log 'auth.send'
		auth = cookie
		socket.emit 'auth.send', cookie
	else
		console.log 'auth.req'
		socket.emit 'auth.req'

socket.on 'auth.get', (data) ->
	console.log "auth.get #{data}"
	auth = data
	$.cookie 'auth', data, {expires: 365}

socket.on 'nick.get', (data) ->
	console.log "nick.get #{data}"
	nick = data

message = (data) ->
	if data[0] == '/'
		split = data[1..].split ' '
		cmd = split[0]
		if commands[cmd] != undefined
			commands[cmd] split[1..].join ' '
		else
			alert "Incorrect command #{cmd}"

commands =
	nick: (nickname) ->
		socket.emit 'nick.set', addauth nickname
		
addauth = (data) ->
	{auth: auth, data: data}
