#!/bin/bash

# 暂停, 按空格键后继续
function pause {
    local msg="Press enter to continue..."
    [[ -n "$1" ]] && msg="$1"
    read -p "$msg"
}

function require {
    if ! hash "$1" &>/dev/null; then
        error "Need '$1' (Command not found)"
        exit 1
    fi
}
