auth = ''
nick = ''



socket = io.connect 'http://localhost', {port:81}

socket.on 'connect', ->
	console.log 'connected'
	cookie = $.cookie 'auth'
	if cookie != null
		console.log 'sendauth'
		socket.emit 'sendauth', cookie
	else
		console.log 'reqauth'
		socket.emit 'reqauth'

socket.on 'getauth', (data) ->
	console.log "getauth #{data}"
	auth = data
	$.cookie 'auth', data, {expires: 365}

socket.on 'getnick', (data) ->
	console.log "getnick #{data}"
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
		socket.emit 'nick', addauth nickname
		
addauth = (data) ->
	{auth: auth, data: data}
