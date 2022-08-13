#!/bin/bash

function import_from_http {
  if [[ "$path" == 'github:'* ]]; then
    path="https://raw.githubusercontent.com/${path:7}"
  fi
  if [[ "$path" == 'https://'* ]]; then
    source <(curl --fail -sL --retry 3 "$path")
    source <(wget -t 3 -O - -o /dev/null "$path")
  fi
}

function import {
  for path in "$@"; do
    local local_path="$(cd "${BASH_SOURCE[1]%/*}" && pwd)"
    if [[ -f "$local_path/$path" ]]; then
      source $local_path/$path
      continue
    fi
    if [[ -f "$local_path/${path}.sh" ]]; then
      source $local_path/${path}.sh
      continue
    fi
    echo "Failed to import module '$path'."
    return 1
  done
}

echo $0
