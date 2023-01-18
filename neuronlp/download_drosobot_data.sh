#!/bin/bash

set -e

if [ $# -eq 0 ]
then
    read -p "Please enter the directory where you download the Drosobot data (press N or n to quit): " -r DATA_DIR
    if [ "$DATA_DIR" == "N" ] || [ "$DATA_DIR" == "n" ]
    then
        echo
        exit 0;
    fi
fi

if [ $# -gt 0 ]
then
    DATA_DIR=$1
fi

mkdir -p $DATA_DIR

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yqYFoVFA5jvORaCX06U2mkUkbfiajZVL' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1O92ln6BfAgAVQSUmh5C3e2kk6ojn7rkt" -O $DATA_DIR/GD_augmented.gexf && rm -rf /tmp/cookies.txt

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yqYFoVFA5jvORaCX06U2mkUkbfiajZVL' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1O92ln6BfAgAVQSUmh5C3e2kk6ojn7rkt" -O $DATA_DIR/GV_augmented.gexf && rm -rf /tmp/cookies.txt

