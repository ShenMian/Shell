#!/bin/bash

import oo

class Timer
    pub
        fn Timer
        fn restart
        fn getSeconds
        fn getMilliseconds
    var start_time

function Timer::Timer {
    start_time="$(date +%s.%2N)"
}

function Timer::restart {
    start_time="$(date +%s.%2N)"
}

function Timer::getSeconds {
    echo $( echo "$(date +%s.%2N) - $start_time" | bc | awk '{printf "%.0f", $0}' )
}

function Timer::getMilliseconds {
    echo $( echo "$(date +%s.%2N) - $start_time" | bc | awk '{printf "%.2f", $0}' )
}
