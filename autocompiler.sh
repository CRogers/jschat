#!/bin/sh

# See https://github.com/CRogers/FileWatcher

filewatcher "src/server/" "*.coffee" "coffee -o compiled/server/ -c :path" "rm compiled/server/:wefile.js" &
filewatcher "src/client/" "*.haml" "haml :path >compiled/client/:wefile.html" "rm compiled/client/:wefile.html" &

filewatcher "src/client/scripts" "*.coffee" "coffee -b -o compiled/client/ -c :path" "rm compiled/client/:wefile.js" &
sass --watch src/client/stylesheets:compiled/client
