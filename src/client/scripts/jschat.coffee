auth = ''

socket = io.connect 'http://localhost', {port:81}
socket.on 'giveauth', (data) ->
	console.log data
	auth = data

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
