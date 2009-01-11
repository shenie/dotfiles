#!/bin/sh

ps aux | grep nginx | grep nobody | while read f pid j
do
  sudo kill $pid
done
