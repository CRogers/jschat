(function() {
  var Auth, AuthS, Schema, mongoose;
  mongoose = require('mongoose');
  mongoose.connect('mongodb://localhost/jschat');
  Schema = mongoose.Schema;
  AuthS = new Schema({
    auth: {
      type: String,
      unique: true
    },
    nick: String,
    time: Date
  });
  Auth = mongoose.model('Auth', AuthS);
  exports.setnick = function(auth, nick) {
    var a;
    a = new Auth();
    a.auth = auth;
    a.nick = nick;
    a.time = new Date();
    return a.save(function(err) {
      return console.log(err);
    });
  };
  exports.getnick = function(auth, callback) {
    console.log("db.getnick " + auth);
    return Auth.findOne({
      auth: auth
    }, function(auth) {
      return console.log(auth);
    });
  };
}).call(this);
