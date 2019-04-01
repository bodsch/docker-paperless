#!/bin/bash

consumer=$(ps ax -o pid,args | grep -v grep | egrep -c document_consumer)
runserver=$(ps ax -o pid,args | grep -v grep | egrep -c runserver)

if [ ${consumer} -eq 1 ] && [ ${runserver} -eq 0 ]
then
  exit 0

else
  curl_opts="--silent --fail"

  if curl ${curl_opts} http://localhost:8000
  then
    # validation are not successful
    #
    if [[ $? -gt 0 ]]
    then
      exit 1
    fi

    exit 0
  fi
fi

exit 2
