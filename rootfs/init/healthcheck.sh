#!/bin/bash

consumer=$(pgrep -f document_consumer)
runserver=$(pgrep -f runserver)

[ -z "${consumer}" ] && consumer=0
[ -z "${runserver}" ] && runserver=0

if [ "${consumer}" -eq 1 ] && [ "${runserver}" -eq 0 ]
then
  exit 0

else
  if curl --silent --fail http://localhost:8000/admin/ > /dev/null
  then
    exit 0
  fi
  exit 1
fi

exit 2
