#!/usr/bin/env bash
set -euo pipefail
FILE_PATH=$(dirname -- "${1:?Expected a document path}")
exec /opt/homebrew/bin/wezterm start --cwd "$FILE_PATH"
