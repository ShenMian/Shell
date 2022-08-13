#!/bin/bash

source "$(dirname $0)/require.sh"
require oo

class Timer
    fn Timer
    fn start
    fn print
    var start_time

Timer::Timer() {
    echo hi
}

Timer::start() {
    start_time=$(date +%s.%2N)
}

Timer::print() {
    local elapse=$(echo "$(date +%s.%2N) - $start_time" | bc)
    echo $elapse
}
