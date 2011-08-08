var addauth, auth, commands, message, socket;
auth = '';
socket = io.connect('http://localhost', {
  port: 81
});
socket.on('giveauth', function(data) {
  console.log(data);
  return auth = data;
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