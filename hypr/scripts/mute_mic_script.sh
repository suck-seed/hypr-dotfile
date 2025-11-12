# CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")

# MUTE_STATUS=$(pactl list sources | grep -A 10 $CURRENT_SOURCE | grep "Mute")

# IS_MUTE=$(echo "$MUTE_STATUS" | awk '{print $NF}')

# STATUS=1
# if [ $IS_MUTE != "no" ]; then
#   STATUS=0
# fi

# TEMP=$(echo $STATUS| sudo tee /sys/class/leds/platform\:\:micmute/brightness)

# pactl -- set-source-mute 0 toggle

#!/usr/bin/env bash
set -euo pipefail

LED="/sys/class/leds/platform::micmute/brightness"

# Toggle mic mute via PipeWire
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
# slight delay so state updates
sleep 0.05

# Read current state and set LED: 1 = LED on (muted), 0 = off
if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q '\[MUTED\]'; then
  VAL=1
else
  VAL=0
fi

# Try writing directly; if it fails, fall back to sudo (see #2 below)
echo "$VAL" > "$LED" 2>/dev/null || sudo -n tee "$LED" >/dev/null <<<"$VAL"
