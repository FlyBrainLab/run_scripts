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

read -p "Download Larva L1EM? (y/N) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [ -d "l1em" ]
    then
        echo
        read -p  "Database $ORIENTDB_DIR/databases/l1em will be overwritten, continue? (y/N) " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rm -rf l1em/*.*
            echo "Downloading Neuroarch database for Larva L1EM dataset"
            wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1hYjA43poDjL8WtQ1AUBzYxKTaJ4In-GU' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1hYjA43poDjL8WtQ1AUBzYxKTaJ4In-GU" -O l1em.zip && rm -rf /tmp/cookies.txt
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ../databases/l1em.zip"
            rm l1em.zip
        else
            echo "Database l1em not downloaded."
        fi
    else
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1hYjA43poDjL8WtQ1AUBzYxKTaJ4In-GU' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1hYjA43poDjL8WtQ1AUBzYxKTaJ4In-GU" -O l1em.zip && rm -rf /tmp/cookies.txt
        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ../databases/l1em.zip"
        rm l1em.zip
    fi
fi

echo
