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
    console.log('auth.send');
    auth = cookie;
    return socket.emit('auth.send', cookie);
  } else {
    console.log('auth.req');
    return socket.emit('auth.req');
  }
});
socket.on('auth.get', function(data) {
  console.log("auth.get " + data);
  auth = data;
  return $.cookie('auth', data, {
    expires: 365
  });
});
socket.on('nick.get', function(data) {
  console.log("nick.get " + data);
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
    return socket.emit('nick.set', addauth(nickname));
  }
};
addauth = function(data) {
  return {
    auth: auth,
    data: data
  };
};