#!/bin/bash

source "$(dirname $0)/require.sh"
require color

echo_colored() {
  printf '%b\n' "$1$2$Color_off" >&2
}

function good() {
  echo "${Green}[✔]${Color_off} ${1}${2}"
}

function info() {
  echo "${Blue}[➭]${Color_off} ${1}${2}"
}

function error() {
  echo "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

function warn() {
  echo "${Yellow}[⚠]${Color_off} ${1}${2}"
}
