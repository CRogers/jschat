#!/bin/sh

# See https://github.com/CRogers/FileWatcher

filewatcher "src/client/" "*.haml" "haml :path >compiled/client/:wefile.html" "rm compiled/client/:wefile.html" &
filewatcher "src/server/" "*.coffee" "coffee -o compiled/server/ -c :path" "rm compiled/server/:wefile.js" &

sass --watch src/client/stylesheets:compiled/client
