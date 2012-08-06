#!/bin/sh

# Generate costum commit messages

### if on OS X, ask iTunes for the current playing track
[[ $(uname) == "Darwin" ]] && osascript -e 'tell application "System Events" to if ((name of processes) contains "iTunes") then do shell script ("osascript -e " & quoted form of ("tell application \"iTunes\" to if player state is playing then \"iTunes is playing: \" & name of current track & \" - \" & artist of current track" & ""))'

### if on OS X, get the current Wifi SSID
[[ $(uname) == "Darwin" ]] && \
    AIRPORT_STATUS=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
    echo "$AIRPORT_STATUS" | grep "AirPort: Off">/dev/null && WIFI_STATUS="Off" && echo "Wifi: "$WIFI_STATUS""
    [[ ! $WIFI_STATUS == "Off" ]] && WIFI_STATUS=$(echo "$AIRPORT_STATUS" | awk -F': ' '/ SSID/ {print $2}') && echo "Wifi: "$WIFI_STATUS""
