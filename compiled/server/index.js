(function() {
  var io;
  io = require('socket.io').listen(81);
  io.sockets.on('connection', function(socket) {
    console.log('hi');
    socket.emit('news', {
      hello: 'world'
    });
    return socket.on('my other event', function(data) {
      return console.log(data);
    });
  });
}).call(this);
