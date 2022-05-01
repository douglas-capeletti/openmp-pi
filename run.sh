#!/bin/bash
if [ "$#" -gt 0 ]; then
    if [ "$#" -eq 1 ]; then
        echo 'Running for "'$1'" steps!'
        gcc -o app pi.c -DNUM_PASSOS=$1 -fopenmp
        ./pi $1
    else
        JUMP=0
        if [ "$#" -eq 2 ]; then
            JUMP=$1
        fi
        if [ "$#" -eq 3 ]; then
            JUMP=$3
        fi
        echo 'Running for range ["'$1'"->"'$2'"] jumping each "'$JUMP'" steps!'
        : >sequencial.tempo
        : >sequencial.output
        for i in $(seq $1 $JUMP $2); do
            gcc -o app pi.c -DNUM_PASSOS=$i -fopenmp
            ./app 1>>sequential.output 2>>sequential.tempo
        done
    fi

else
    echo '###########################################################'
    echo '##              PI Parallel Generator Runner             ##'
    echo '## Linear  : ./run.sh <number_of_steps>                  ##'
    echo '## Interval: ./run.sh <start_value> <final_value>        ##'
    echo '## Interval: ./run.sh <start_value> <final_value> <jump> ##'
    echo '###########################################################'
fi
