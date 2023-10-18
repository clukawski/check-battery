#!/bin/bash

# Query logs via `journalctl --user -t check-battery`
printf 'checking battery level' | systemd-cat -t check-battery

# The format here is "$HOURS:$MINUTES:$SECONDS"
TIME_REMAINING="00:30:00"

BATTINFO=$(acpi -b|tail -1)
CURRENT_TIME_REMAINING="$(echo \"$BATTINFO\" | cut -f 5 -d " ")"
if [[ $(echo "$BATTINFO" | grep Discharging) && "$CURRENT_TIME_REMAINING" < "$TIME_REMAINING" ]] ; then
    # Log to low battery events to syslog and 
    printf 'low battery: %s remaining' "$CURRENT_TIME_REMAINING" | systemd-cat -t check-battery
    DISPLAY=:0 /usr/bin/notify-send -u low "battery" "$BATTINFO"
fi
