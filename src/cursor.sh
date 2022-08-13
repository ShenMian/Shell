#!/bin/bash

function cursor::get {
    local x
    local y

    IFS=';' read -sdR -p $'\E[6n' y x

    y=$(( ${y#*[} - 1 ))
    x=$(( ${x} - 1 ))

    echo $x, $y
}

function cursor::set {
  local -i total_height=$(tput lines)
  local -i y=$1
  local -i x=$2

  [[ $y + 1 == $total_height ]] && y+=-1

  tput cup $y $x
}

