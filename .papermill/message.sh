#!/bin/sh

# Generate costum commit messages

### if on OS X, ask iTunes for the current playing track
[[ $(uname) == "Darwin" ]] && osascript -e 'tell application "System Events" to if ((name of processes) contains "iTunes") then do shell script ("osascript -e " & quoted form of ("tell application \"iTunes\" to if player state is playing then \"iTunes is playing: \" & name of current track & \" - \" & artist of current track" & ""))'
