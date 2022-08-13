#!/bin/bash

import oo

class Timer
    fn Timer
    fn start
    fn print
    var start_time

function Timer::Timer {
    echo hi
}

function Timer::start {
    start_time=$(date +%s.%2N)
}

function Timer::print {
    local elapse=$(echo "$(date +%s.%2N) - $start_time" | bc)
    echo $elapse
}
