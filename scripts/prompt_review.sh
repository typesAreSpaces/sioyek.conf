#!/usr/bin/env bash
set -euo pipefail
FILE_PATH=${1:?Expected a document path}
printf 'Can you review "%s"? Describe the main contributions, weaknesses, and identify any critical mistakes.\n' "$FILE_PATH" | pbcopy
