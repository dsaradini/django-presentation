#!/bin/bash
FILE="django-dev.rst"

LAST=`ls -l "$FILE"`
while true; do
  sleep 1
  NEW=`ls -l "$FILE"`
  if [ "$NEW" != "$LAST" ]; then
    echo "Hovercraft !"
    make compile_dev
    LAST="$NEW"
  fi
done
