#!/bin/bash

set -e

if [ $# -eq 0 ]
then
    read -p "Please enter the directory where you installed OrientDB (press N or n to skip download): " ORIENTDB_DIR
    if [ "$ORIENTDB_DIR" == "n" ]
    then
        echo
        exit 0;
    fi
fi

if [ $# -gt 0 ]
then
    ORIENTDB_DIR=$1
    read -p "Download datasets to $ORIENTDB_DIR? (Y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Nn]$ ]]
    then
        echo
        exit 0
    fi
fi

echo
# prompt to get the path for databases:
#read -p "Please enter the directory where you installed OrientDB (press : " ORIENTDB_DIR

cd $ORIENTDB_DIR/databases

read -p "Download Medulla 7 Column? (y/N) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [ -d "medulla" ]
    then
        echo
        read -p  "Database $ORIENTDB_DIR/databases/medulla will be overwritten, continue? (y/N) " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rm -rf medulla/*.*
            echo "Downloading Neuroarch database for Larva L1EM dataset"
            wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti" -O medulla.zip && rm -rf /tmp/cookies.txt
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
            rm medulla.zip
        else
            echo "Database l1em not downloaded."
        fi
    else
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti" -O medulla.zip && rm -rf /tmp/cookies.txt
        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
        rm medulla.zip
    fi
fi

echo
