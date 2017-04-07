#!/bin/bash

set -ex

find . -name .git -type d -depth 2 | while read d;
do
  cd `dirname $d`
  git pull
  cd -
done
