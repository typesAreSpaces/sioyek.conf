#!/usr/bin/env bash
# Run sioyek-session.sh from inside Sioyek. State-changing commands need Sioyek
# closed, so they detach a worker that quits Sioyek, runs the command and relaunches it.
set -euo pipefail
SESSION=$HOME/.local/scripts/sioyek-session.sh
SIOYEK=/Applications/sioyek.app/Contents/MacOS/sioyek
LOG="$HOME/Library/Application Support/Sioyek Sessions/last-command.log"

status() {
    "$SIOYEK" --execute-command set_status_string --execute-command-data "$1"
}

if [ "${1:-}" = --worker ]; then
    shift
    osascript -e 'quit app "sioyek"'
    for _ in $(seq 60); do
        pgrep -ix sioyek >/dev/null || break
        sleep 0.5
    done
    if ! output=$("$SESSION" "$@" 2>&1); then
        error=$(printf '%s\n' "$output" | grep -m1 '^Error' || printf '%s' "$output" | tail -n1)
        error=${error//\\/\\\\}
        error=${error//\"/\\\"}
        osascript -e "display notification \"$error\" with title \"sioyek-session $1 failed\""
    fi
    printf '%s\n' "$output"
    exec open -a sioyek
fi

ACTION=${1:?Expected an action}
NAME=${2:-}
NAME=${NAME#\"}
NAME=${NAME%\"}

case $ACTION in
    list)
        status "sessions: $("$SESSION" names sessions | tr '\n' ' ')"
        exit 0 ;;
    save|restore)
        [ -n "$NAME" ] || { status "session $ACTION: no name given"; exit 1; }
        if "$SESSION" names sessions | grep -qxF -- "$NAME"; then
            [ "$ACTION" = restore ] || { status "session already exists: $NAME"; exit 1; }
        else
            [ "$ACTION" = save ] || { status "no such session: $NAME"; exit 1; }
        fi
        set -- "$ACTION" "$NAME" ;;
    new)
        set -- new ;;
    *)
        status "unknown session action: $ACTION"; exit 1 ;;
esac

mkdir -p "$(dirname "$LOG")"
nohup bash "$0" --worker "$@" >"$LOG" 2>&1 </dev/null &
