#!/bin/bash
FILE="django-highlevel.rst"

LAST=`ls -l "$FILE"`
while true; do
  sleep 1
  NEW=`ls -l "$FILE"`
  if [ "$NEW" != "$LAST" ]; then
    echo "Hovercraft !"
    make compile_highlevel
    LAST="$NEW"
  fi
done
