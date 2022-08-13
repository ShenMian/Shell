#!/bin/bash

source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/../src/import.sh"
import io system timer

new Timer timer

info 'Infomation'
good 'Good'
error 'Error'
warn 'Warning'

echo "System"
echo "|-Host name: $(get_host_name)"
echo "\`-Arch:      $(get_system_arch)"
echo "CPU"
echo "|-Name:  $(get_cpu_name)"
echo "\`-Cores: $(get_cpu_num)"
echo "USB 001"
echo "|-Version:        $(get_usb_ver 001)"
echo "\`-Devices number: $(get_usb_device_num 001)"

echo "Elapse: $(timer.getSeconds)"
delete timer
