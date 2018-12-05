#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $(basename $0) <path-to-script>"
  exit 1
fi

file_to_check=$1

if [ ! -f $file_to_check ]; then
  echo "Error: $file_to_check is not a file"
  exit 1
fi

docker pull koalaman/shellcheck:stable

docker run -v "$(dirname $file_to_check):/mnt" koalaman/shellcheck:stable $(basename $file_to_check)

