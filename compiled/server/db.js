(function() {
  var Auth, Schema, mongoose;
  mongoose = require('mongoose');
  mongoose.connect('mongodb://localhost/jschat');
  Schema = mongoose.Schema;
  Auth = mongoose.model('Auth', new Schema({
    auth: {
      type: String,
      index: {
        unique: true,
        dropDups: true
      }
    },
    nick: String,
    modified: Date
  }));
  exports.authexists = function(auth) {
    return Auth.count;
  };
  exports.nick = {
    "new": function(auth, nick) {
      var a;
      a = new Auth();
      a.auth = auth;
      a.nick = nick;
      a.modified = new Date();
      console.log("nick.new  " + auth + " " + nick);
      return a.save(function(err) {
        return console.log(err);
      });
    },
    get: function(auth, callback) {
      console.log("nick.get " + auth);
      return Auth.findOne({
        auth: auth
      }, function(err, auth) {
        return callback(auth.nick);
      });
    },
    set: function(auth, nick, callback) {
      console.log("nick.set " + auth + " " + nick);
      return Auth.update({
        auth: auth
      }, {
        nick: nick,
        modified: new Date()
      }, callback);
    }
  };
}).call(this);
