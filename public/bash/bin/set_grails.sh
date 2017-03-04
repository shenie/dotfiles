#!/bin/bash

if [ -e application.properties ] ; then
  current=$(readlink $GRAILS_HOME |cut -d'/' -f7)

  required=$(grep grails.version application.properties | cut -d= -f 2)

  if [ "${required}" != "" -a "${current}" != "${required}" ] ; then
    echo "Switching to grails ${required}"
    sdk use grails ${required}
  fi
fi

if [ -e gradle.properties ] ; then
  current=$(readlink $GRAILS_HOME |cut -d'/' -f7)

  required=$(grep grailsVersion gradle.properties | cut -d= -f 2)

  if [ "${required}" != "" -a "${current}" != "${required}" ] ; then
    echo "Switching to grails ${required}"
    sdk use grails ${required}
  fi
fi
