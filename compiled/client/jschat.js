(function() {
  var socket;
  socket = new io.Socket('http://localhost', {
    port: 81
  });
  socket.on('news', function(data) {
    console.log(data);
    return socket.emit('my other event', {
      my: 'data'
    });
  });
  socket.connect();
}).call(this);
