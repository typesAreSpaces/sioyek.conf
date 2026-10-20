#!/usr/bin/env bash

FILE=$1
FILE=${FILE/$HOME/~}
FILE_NAME=$(basename "${FILE}")
FILE_NAME=${FILE_NAME%?????}
FILE=${FILE:1}
FILE=${FILE%?}
OUTPUT="[[${FILE}][${FILE_NAME}]]"
echo ${OUTPUT} | pbcopy
opt/homebrew/bin/emacsclient -s jose --eval '(kill-new "'"$OUTPUT"'")'
