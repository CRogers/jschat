(function() {
  var db, guid, io;
  db = require('./db');
  io = require('socket.io').listen(81);
  io.sockets.on('connection', function(socket) {
    console.log('hi');
    socket.emit('giveauth', guid());
    return socket.on('nick', function(data) {
      console.log(data);
      return db.setnick(data.auth, data.data);
    });
  });
  guid = function() {
    var S4;
    S4 = function() {
      return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    };
    return S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4();
  };
}).call(this);
