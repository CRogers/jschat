(function() {
  var db, guid, io;
  db = require('./db');
  io = require('socket.io').listen(81);
  io.sockets.on('connection', function(socket) {
    socket.on('auth.send', function(auth) {
      return db.nick.get(auth, function(nick) {
        return socket.emit('nick.get', nick);
      });
    });
    socket.on('auth.req', function() {
      var auth;
      auth = guid();
      db.nick["new"](auth, 'noname');
      socket.emit('auth.get', auth);
      return socket.emit('nick.get', 'noname');
    });
    return socket.on('nick.set', function(data) {
      console.log(data);
      return db.nick.set(data.auth, data.data, function() {
        return db.nick.get(data.auth, function(nick) {
          return socket.emit('nick.get', nick);
        });
      });
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
