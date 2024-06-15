#!/bin/bash

set -e

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV

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

gdown "1Tx9QCJYBnsvjXt3-2ti8QZWUswGCyxZx" -O $DATA_DIR/drosobot_data.tar.gz
#wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Tx9QCJYBnsvjXt3-2ti8QZWUswGCyxZx' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Tx9QCJYBnsvjXt3-2ti8QZWUswGCyxZx" -O $DATA_DIR/drosobot_data.tar.gz && rm -rf /tmp/cookies.txt

tar xf $DATA_DIR/drosobot_data.tar.gz --directory $DATA_DIR
rm $DATA_DIR/drosobot_data.tar.gz
