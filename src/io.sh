#!/bin/bash

source "$(dirname $0)/require.sh"
require color

echo_with_color() {
  printf '%b\n' "$1$2$Color_off" >&2
}

println() {
  printf '%b\n' "$1$2$Color_off" >&2
}

function success() {
  println "${Green}[✔]${Color_off} ${1}${2}"
}

function info() {
  println "${Blue}[➭]${Color_off} ${1}${2}"
}

function error() {
  println "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

function warn() {
  println "${Yellow}[⚠]${Color_off} ${1}${2}"
}
