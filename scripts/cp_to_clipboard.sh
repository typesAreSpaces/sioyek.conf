set -euo pipefail
FILE_PATH=${1:?Expected a document path}
FILE_PATH=${FILE_PATH#\"}
FILE_PATH=${FILE_PATH%\"}
printf '"%s"' "$(dirname -- "$FILE_PATH")" | pbcopy
