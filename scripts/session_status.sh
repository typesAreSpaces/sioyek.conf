#!/usr/bin/env bash

name=$("$HOME/.local/scripts/sioyek-session.sh" current 2>/dev/null)
if [ -n "$name" ]; then
    /Applications/sioyek.app/Contents/MacOS/sioyek --execute-command set_status_string --execute-command-data "[$name]"
else
    /Applications/sioyek.app/Contents/MacOS/sioyek --execute-command clear_status_string
fi
