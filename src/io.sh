#!/bin/bash

import color

function echo_colored {
  printf '%b\n' "$1$2$Color_off" >&2
}

function info {
  echo -e "${Blue}[➭]${Color_off} ${1}${2}"
}

function good {
  echo -e "${Green}[✔]${Color_off} ${1}${2}"
}

function error {
  echo -e "${Red}[✘]${Color_off} ${1}${2}"
}

function warn {
  echo -e "${Yellow}[⚠]${Color_off} ${1}${2}"
}
