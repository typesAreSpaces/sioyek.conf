#!/usr/bin/env bash
set -euo pipefail
FILE=${1:?Expected a document path}
FILE_NAME=$(basename -- "$FILE")
FILE_NAME=${FILE_NAME%.*}
# Escape characters that have special meaning in Org link targets.
TARGET=${FILE//%/%25}
TARGET=${TARGET//\[/%5B}
TARGET=${TARGET//\]/%5D}
LABEL=${FILE_NAME//[/\\[}
LABEL=${LABEL//]/\\]}
OUTPUT="[[file:${TARGET}][${LABEL}]]"
printf '%s' "$OUTPUT" | pbcopy
# Escape the value as an Emacs Lisp string before passing it to kill-new.
LISP_STRING=${OUTPUT//\\/\\\\}
LISP_STRING=${LISP_STRING//\"/\\\"}
LISP_STRING=${LISP_STRING//$'\n'/\\n}
LISP_STRING=${LISP_STRING//$'\r'/\\r}
exec /opt/homebrew/bin/emacsclient -s jose --eval "(kill-new \"${LISP_STRING}\")"
