#!/bin/bash

if [ -e application.properties ] ; then
  echo "Found application.properties"

  current=$(realpath $GRAILS_HOME |cut -d'/' -f6)
  echo "Using grails ${current}"

  required=$(grep grails.version application.properties | cut -d= -f 2)

  if [ "${current}" != "${required}" ] ; then
    echo "Switching to grails ${required}"
    gvm use grails ${required}
  fi
fi

