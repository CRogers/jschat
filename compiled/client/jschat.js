var addauth, auth, commands, message, nick, socket;
auth = '';
nick = '';
socket = io.connect('http://localhost', {
  port: 81
});
socket.on('connect', function() {
  var cookie;
  console.log('connected');
  cookie = $.cookie('auth');
  if (cookie !== null) {
    console.log('sendauth');
    return socket.emit('sendauth', cookie);
  } else {
    console.log('reqauth');
    return socket.emit('reqauth');
  }
});
socket.on('getauth', function(data) {
  console.log("getauth " + data);
  auth = data;
  return $.cookie('auth', data, {
    expires: 365
  });
});
socket.on('getnick', function(data) {
  console.log("getnick " + data);
  return nick = data;
});
message = function(data) {
  var cmd, split;
  if (data[0] === '/') {
    split = data.slice(1).split(' ');
    cmd = split[0];
    if (commands[cmd] !== void 0) {
      return commands[cmd](split.slice(1).join(' '));
    } else {
      return alert("Incorrect command " + cmd);
    }
  }
};
commands = {
  nick: function(nickname) {
    return socket.emit('nick', addauth(nickname));
  }
};
addauth = function(data) {
  return {
    auth: auth,
    data: data
  };
};