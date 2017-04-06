#!/bin/bash

set -ex

find . -name .git -type d -depth 2 | while read d \
do
  x=`dirname $d`
  cd $x
  git pull
  cd -
done
