#!/bin/bash

if [ -e application.properties ] ; then
  current=$(realpath $GRAILS_HOME |cut -d'/' -f6)

  required=$(grep grails.version application.properties | cut -d= -f 2)

  if [ "${required}" != "" -a "${current}" != "${required}" ] ; then
    echo "Switching to grails ${required}"
    gvm use grails ${required}
  fi
fi

