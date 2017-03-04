#!/bin/bash

echo -n -e "\033]0;`hostname -s`:`pwd | sed -e"s#${HOME}#~#"`\007"
