#!/bin/sh

cache_dir="${HOME}/Library/Caches/Firefox/Profiles/*.default/Cache"
for file in `ls $cache_dir`
do
#  file $cache_dir/$file
  count=`file $cache_dir/$file | egrep -ci "(mp3|stereo)"`
  if [ $count == 1 ] ; then
    echo "found music in $file"
    mv $cache_dir/$file ~/Music/${file}.mp3
  fi
done


