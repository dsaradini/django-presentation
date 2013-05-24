#!/bin/bash
FILE="django.rst"

LAST=`ls -l "$FILE"`
while true; do
  sleep 1
  NEW=`ls -l "$FILE"`
  if [ "$NEW" != "$LAST" ]; then
    echo "Hovercraft !"
    make
    LAST="$NEW"
  fi
done
