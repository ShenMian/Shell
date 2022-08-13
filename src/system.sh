#!/bin/bash

function require {
    if ! hash "$1" &>/dev/null; then
        error "Need '$1' (Command not found)"
        exit 1
    fi
}

# 暂停, 按空格键后继续
function pause {
    local msg="Press enter to continue..."
    [[ -n "$1" ]] && msg="$1"
    read -p "$msg"
}

function get_host_name {
    require uname
    uname -n
}

function get_system_arch {
    require uname
    case $(uname --m) in
    x86_64)
        echo 'x64'
        ;;
    i*86)
        echo 'x86'
        ;;
    *)
        ;;
    esac
}

function get_cpu_name {
    lscpu | grep "Model name" | cut -d ":" -f 2 | xargs
}

function get_cpu_num {
    nproc --all
}

# $1: USB 端口号
function get_usb_ver {
    require lsusb
    lsusb | grep "root hub" | cut -d ' ' -f 2,9 | grep "$1" | cut -d ' ' -f 2
}
function get_usb_device_num {
    require lsusb
    echo $(($(lsusb | cut -d ' ' -f 2 | grep "$1" | wc -l) - 1))
}
