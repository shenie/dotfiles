#!/bin/bash

current=$(sdk current grails | cut -d' ' -f4)

if [ -e application.properties ] ; then

  required=$(grep grails.version application.properties | cut -d= -f 2)

  if [ "${required}" != "" -a "${current}" != "${required}" ] ; then
    sdk use grails ${required}
  fi
fi

if [ -e gradle.properties ] ; then

  required=$(grep grailsVersion gradle.properties | cut -d= -f 2)

  if [ "${required}" != "" -a "${current}" != "${required}" ] ; then
    sdk use grails ${required}
  fi
fi
