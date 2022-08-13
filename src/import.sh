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

function import_once {
    local local_path="$(cd "${BASH_SOURCE[1]%/*}" && pwd)"
    if [[ -f "$local_path/$path" ]]; then
      source $local_path/$path
      return 0
    fi
    if [[ -f "$local_path/${path}.sh" ]]; then
      source $local_path/${path}.sh
      return 0
    fi
    echo "Failed to import module '$path'."
    return 1
} 

function import {
    for path in "$@"; do
        import_once $path || exit 1
    done
}

