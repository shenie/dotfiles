#!/bin/bash

current=$(pwd)

destination=${current}/${1}

osascript 2>/dev/null <<EOF

  tell application "System Events"
    tell process "Terminal" to keystroke "t" using command down
  end

  tell application "Terminal"
    do script with command "cd $destination" in window 1
  end tell

EOF

