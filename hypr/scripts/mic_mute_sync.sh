# #!/usr/bin/env bash
# set -euo pipefail
# LED="/sys/class/leds/platform::micmute/brightness"

# if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q '\[MUTED\]'; then
#   VAL=1
# else
#   VAL=0
# fi

# echo "$VAL" > "$LED" 2>/dev/null || sudo -n tee "$LED" >/dev/null <<<"$VAL"
