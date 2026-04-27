#!/bin/bash
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

bar_length=${#bar}
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

config_file="/tmp/bar_cava_config"

cat >"$config_file" <<EOF
[general]
bars = 10

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

cleanup() {
    pkill -f "cava -p $config_file" 2>/dev/null
}

trap cleanup EXIT

is_playing() {
    status=$(playerctl --player=spotify status 2>/dev/null)
    [[ "$status" == "Playing" ]]
}


while true; do
    if is_playing; then
        cava -p "$config_file" 2>/dev/null | while read -r line; do
            if is_playing; then
                echo "$line" | sed -u "$dict"
            else
                cleanup
                break
            fi
        done
    else
        echo ""
        sleep 1
    fi
done
