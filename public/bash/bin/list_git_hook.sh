#!/bin/bash

basedir=$(git rev-parse --show-toplevel 2>/dev/null)

if [ $? -eq 0 ]; then
  find ${basedir}/.git/hooks -type f ! -name "*.sample"
fi

