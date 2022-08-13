#!/bin/bash

_LIBARAY_PATH="$(dirname $0)"

# 导入脚本
function require() {
  for require in "$@"; do
    local file="$require"
    [[ -f "${file##*/}.sh" ]] && file="${file##*/}.sh"
    [[ -f "$_LIBARAY_PATH/$file" ]] && file="$_LIBARAY_PATH/$file"
    [[ -f "$_LIBARAY_PATH/${file##*/}.sh" ]] && file="$_LIBARAY_PATH/${file##*/}.sh"
    [[ -f "$file" ]] || return 1
    source "$file"
  done
}
