#!/bin/bash

CURRENT=$(asusctl profile get | grep "Active profile" | awk '{print $3}')

if [ "$1" = "click" ]; then
    case "$CURRENT" in
        Quiet)
            asusctl profile set Balanced
            ;;
        Balanced)
            asusctl profile set Performance
            ;;
        Performance)
            asusctl profile set Quiet
            ;;
    esac
    exit 0
fi

case "$CURRENT" in
    Quiet)
        ICON="  "
        CLASS="quiet"
        ;;
    Balanced)
        ICON=" 󰇥 "
        CLASS="balanced"
        ;;
    Performance)
        ICON="  "
        CLASS="performance"
        ;;
esac

echo "{\"text\":\"$ICON\",\"class\":\"$CLASS\"}"
