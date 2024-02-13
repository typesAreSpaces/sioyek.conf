#!/usr/bin/env bash

FILE_PATH=$(dirname $1)
FILE_PATH=${FILE_PATH:1}
echo ${FILE_PATH} | pbcopy
