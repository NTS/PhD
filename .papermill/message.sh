#!/bin/sh

# Generate costum commit messages

# Get the local time
echo "Local Time: $(date)"


### if on OS X, ask iTunes for the current playing track
[[ $(uname) == "Darwin" ]] && osascript -e 'tell application "System Events" to if ((name of processes) contains "iTunes") then do shell script ("osascript -e " & quoted form of ("tell application \"iTunes\" to if player state is playing then \"iTunes is playing: \" & name of current track & \" - \" & artist of current track" & ""))'

### if on OS X, get the current Wifi SSID #fixme
[[ $(uname) == "Darwin" ]] && \
AIRPORT_STATUS=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
echo "$AIRPORT_STATUS" | grep "AirPort: Off">/dev/null && WIFI_STATUS="Off"
[[ ! $WIFI_STATUS == "Off" ]] && WIFI_STATUS=$(echo "$AIRPORT_STATUS" | awk -F': ' '/ SSID/ {print $2}') && echo "Wifi SSID: "$WIFI_STATUS""
#

### if TempMonitor.app is installed, get the current Temperature
MAC_TEMPERATURE_TOOL="/Applications/TemperatureMonitor.app/Contents/MacOS/tempmonitor"
[[ -f "$MAC_TEMPERATURE_TOOL" ]] && echo Temperature "$($MAC_TEMPERATURE_TOOL -a -l -c | grep "SMC LEFT PALM REST: " | cut -c 5-99)"

### if on OS X, get Software info from 'system_profiler' #fixme
[[ $(uname) == "Darwin" ]] && system_profiler SPSoftwareDataType | grep "User Name: " | cut -c 7-99
[[ $(uname) == "Darwin" ]] && system_profiler SPSoftwareDataType | grep "System Version: " | cut -c 7-99
[[ $(uname) == "Darwin" ]] && system_profiler SPSoftwareDataType | grep "Time since boot: " | cut -c 7-99

### if on OS X, get Hardware and Power info from 'system_profiler' #fixme
[[ $(uname) == "Darwin" ]] && system_profiler SPHardwareDataType | grep "Model Name: " | cut -c 7-99
[[ $(uname) == "Darwin" ]] && system_profiler SPHardwareDataType | grep "Model Identifier: " | cut -c 7-99
[[ $(uname) == "Darwin" ]] && system_profiler SPHardwareDataType | grep "Model Name: " | cut -c 7-99
[[ $(uname) == "Darwin" ]] && echo "AC Charger $(system_profiler SPPowerDataType | grep "Connected: Yes" | cut -c 7-99)"
[[ $(uname) == "Darwin" ]] && system_profiler SPPowerDataType | grep "Fully Charged: " | cut -c 11-99
[[ $(uname) == "Darwin" ]] && system_profiler SPPowerDataType | grep "Charging: " | head -1 | cut -c 11-99
[[ $(uname) == "Darwin" ]] && system_profiler SPPowerDataType | grep "Charge Remaining (mAh): " | cut -c 11-99

### if on OS X, get active network info from 'system_profiler' #fixme
#[[ $(uname) == "Darwin" ]] && echo "Network: "
#[[ $(uname) == "Darwin" ]] && system_profiler SPNetworkDataType | grep -B5 -A1 "Has IP Assigned: Yes"
