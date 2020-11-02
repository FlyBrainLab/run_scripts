#!/bin/bash

set -e

# prompt to get the path for databases:
read -p "Directory where you want to store the databases: " DATABASE_DIR

if [ -d "$DATABASE_DIR/hemibrain"]
then
    read -p  "Database $DATABASE_DIR/hemibrain will be overwritten, continue? (y/N) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm -rf hemibrain
        echo "Downloading Neuroarch database for Hemibrain dataset"
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1puvabvKGFBchKiD56cjlu3MFNQ-Soam1' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1puvabvKGFBchKiD56cjlu3MFNQ-Soam1" -O hemibrain.tar.gz && rm -rf /tmp/cookies.txt

        tar zxf hemibrain.tar.gz
        rm hemibrain.tar.gz
    else
        echo "Database hemibrain not downloaded."
    fi
else
    echo "Downloading Neuroarch database for Hemibrain dataset"
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1puvabvKGFBchKiD56cjlu3MFNQ-Soam1' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1puvabvKGFBchKiD56cjlu3MFNQ-Soam1" -O hemibrain.tar.gz && rm -rf /tmp/cookies.txt

    tar zxf hemibrain.tar.gz
    rm hemibrain.tar.gz
fi

if [ -d "$DATABASE_DIR/flycircuit"]
then
    read -p  "Database $DATABASE_DIR/flycircuit will be overwritten, continue? (y/N) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm -rf hemibrain
        echo "Downloading Neuroarch database for FlyCircuit dataset"
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Nbo0C55X52OeYJtYVzB-52mo7I7H4UCc' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Nbo0C55X52OeYJtYVzB-52mo7I7H4UCc" -O flycircuit.tar.gz && rm -rf /tmp/cookies.txt

        tar zxf flycircuit.tar.gz
        rm flycircuit.tar.gz
    else
        echo "Database hemibrain not downloaded."
    fi
else
    echo "Downloading Neuroarch database for FlyCircuit dataset"
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Nbo0C55X52OeYJtYVzB-52mo7I7H4UCc' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Nbo0C55X52OeYJtYVzB-52mo7I7H4UCc" -O flycircuit.tar.gz && rm -rf /tmp/cookies.txt

    tar zxf flycircuit.tar.gz
    rm flycircuit.tar.gz
fi


if [ -d "$DATABASE_DIR/l1em"]
then
    read -p  "Database $DATABASE_DIR/l1em will be overwritten, continue? (y/N) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm -rf l1em
        echo "Downloading Neuroarch database for Larva L1EM dataset"
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1U4TfYXzhN7siQtwupDDmgW7sOBRXmQrL' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1U4TfYXzhN7siQtwupDDmgW7sOBRXmQrL" -O l1em.tar.gz && rm -rf /tmp/cookies.txt
        tar zxf l1em.tar.gz
        rm l1em.tar.gz
    else
        echo "Database l1em not downloaded."
    fi
else
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1U4TfYXzhN7siQtwupDDmgW7sOBRXmQrL' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1U4TfYXzhN7siQtwupDDmgW7sOBRXmQrL" -O l1em.tar.gz && rm -rf /tmp/cookies.txt
    tar zxf l1em.tar.gz
    rm l1em.tar.gz
fi
