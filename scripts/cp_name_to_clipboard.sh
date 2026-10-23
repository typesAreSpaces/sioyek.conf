#!/usr/bin/env bash
set -euo pipefail
FILE_PATH=${1:?Expected a document path}
printf '%s' "$FILE_PATH" | pbcopy
