#!/bin/bash

ui_request() {

  curl \
    --silent \
    --head \
    --location \
    http://localhost:8080/admin/
}

inspect() {

  echo ""
  echo "inspect needed containers"
  for d in $(docker ps | tail -n +2 | awk  '{print($1)}')
  do
    # docker inspect --format "{{lower .Name}}" ${d}
    c=$(docker inspect --format '{{with .State}} {{$.Name}} has pid {{.Pid}} {{end}}' "${d}")
    s=$(docker inspect --format '{{json .State.Health }}' "${d}" | jq --raw-output .Status)

    printf "%-40s - %s\n"  "${c}" "${s}"
  done
  echo ""
}

inspect
ui_request

exit 0
