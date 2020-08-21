#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--contains) checkContain=1; string="$2"; shift ;;
        *) if [ -z "$fn" ]; then fn="$1"; else echo "Invalid argument passed"; exit 1; fi ;;
    esac
    shift
done


if [ ! -f "$fn" ]; then
    RESULT="`{ wget -O- $fn  || exit 1; } | grep -Po '(?<=href=")[^"#]*'`"
else
    RESULT="`grep -Po '(?<=href=")[^"#]*' "$fn"`"
fi

[ -n "$checkContain" ] && RESULT="`grep "$string" <<< "$RESULT"`"

echo $RESULT | tr " " "\n"
