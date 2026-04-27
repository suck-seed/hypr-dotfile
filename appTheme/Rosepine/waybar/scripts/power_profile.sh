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

# Display icon
case "$CURRENT" in
    Quiet) echo "  " ;;
    Balanced) echo " 󰇥 " ;;
    Performance) echo "  " ;;
esac
