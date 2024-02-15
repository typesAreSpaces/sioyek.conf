#!/usr/bin/env bash

FILE_PATH=$(dirname $1)
FILE_PATH=${FILE_PATH:1}
/opt/homebrew/bin/alacritty --working-directory ${FILE_PATH}
