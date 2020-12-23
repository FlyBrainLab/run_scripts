#!/bin/bash

set -e

read -p "Download datasets? (Y/n)" -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]]
then
    echo
    exit 0
fi

echo
# prompt to get the path for databases:
read -p "Please enter the directory where you installed OrientDB: " ORIENTDB_DIR

cd $ORIENTDB_DIR/databases

read -p "Download Hemibrain? (y/N) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [ -d "hemibrain" ]
    then
        echo
        read -p  "Database $ORIENTDB_DIR/databases/hemibrain will be overwritten, continue? (y/N) " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rm -rf hemibrain/*.*
            echo "Downloading Neuroarch database for Hemibrain dataset"
            wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Y63UpypJ-eMgOdX3bcSRO4Ct3DqmH6-X' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Y63UpypJ-eMgOdX3bcSRO4Ct3DqmH6-X" -O hemibrain.zip && rm -rf /tmp/cookies.txt
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ../databases/hemibrain.zip"
            rm hemibrain.zip
        else
            echo "Database hemibrain not downloaded."
        fi
    else
        echo "Downloading Neuroarch database for Hemibrain dataset"
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Y63UpypJ-eMgOdX3bcSRO4Ct3DqmH6-X' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Y63UpypJ-eMgOdX3bcSRO4Ct3DqmH6-X" -O hemibrain.zip && rm -rf /tmp/cookies.txt
        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ../databases/hemibrain.zip"
        rm hemibrain.zip
    fi
fi

echo

read -p "Download FlyCircuit? (y/N) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [ -d "flycircuit" ]
    then
        echo
        read -p  "Database $ORIENTDB_DIR/databases/flycircuit will be overwritten, continue? (y/N) " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rm -rf flycircuit/*.*
            echo "Downloading Neuroarch database for FlyCircuit dataset"
            wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1JXtWt-2X66Mb5I271YRUiMuQx3I2b43s' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1JXtWt-2X66Mb5I271YRUiMuQx3I2b43s" -O flycircuit.zip && rm -rf /tmp/cookies.txt
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ../databases/flycircuit.zip"
            rm flycircuit.zip
        else
            echo "Database hemibrain not downloaded."
        fi
    else
        echo "Downloading Neuroarch database for FlyCircuit dataset"
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1JXtWt-2X66Mb5I271YRUiMuQx3I2b43s' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1JXtWt-2X66Mb5I271YRUiMuQx3I2b43s" -O flycircuit.zip && rm -rf /tmp/cookies.txt
        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ../databases/flycircuit.zip"
        rm flycircuit.zip
    fi
fi

echo

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
            wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1XrQWCMB6Y3ADLfWBVF8kA_44KxTVnIq7' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1XrQWCMB6Y3ADLfWBVF8kA_44KxTVnIq7" -O medulla.zip && rm -rf /tmp/cookies.txt
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
            rm l1em.zip
        else
            echo "Database l1em not downloaded."
        fi
    else
        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1XrQWCMB6Y3ADLfWBVF8kA_44KxTVnIq7' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1XrQWCMB6Y3ADLfWBVF8kA_44KxTVnIq7" -O medulla.zip && rm -rf /tmp/cookies.txt
        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
        rm medulla.zip
    fi
fi
