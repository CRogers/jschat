var io;
io = require('socket.io').listen(81);
io.sockets.on('connection', function(socket) {
  socket.on('set nick', function(name) {
    return socket.set('nick', name, function() {
      return socket.emit('ready');
    });
  });
  return socket.on('msg', function() {
    return socket.get('nickname', function(name) {
      return console.log('Chat messaged by', name);
    });
  });
});