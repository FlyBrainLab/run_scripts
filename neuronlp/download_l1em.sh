#!/bin/bash

set -e

if [ $# -eq 0 ]
then
    read -p "Please enter the directory where you installed OrientDB (press N or n to skip download): " -r ORIENTDB_DIR
    if [ "$ORIENTDB_DIR" == "n" ]
    then
        echo
        exit 0;
    fi
fi

if [ $# -gt 0 ]
then
    ORIENTDB_DIR=$1
    while true
    do
        read -p "Load datasets to $ORIENTDB_DIR? (Y/n) " -r
        case $REPLY in
            [Yy]* ) break
                    ;;
            [Nn]* ) echo
                    exit 0
                    ;;
            "" )    break
                    ;;
            * ) echo "Please answer yes or no. "
                ;;
        esac
    done
fi

echo

cd $ORIENTDB_DIR/databases

read -p "Please enter the full path (starting with /) if you have the Larva L1EM dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo
        if [ -d "l1em" ]
        then
            while true
            do
                read -p "Database $ORIENTDB_DIR/databases/l1em will be overwritten, continue? (y/N) " -r
                case $REPLY in
                    [Yy]* ) rm -rf l1em/*.*
                            echo "Loading Neuroarch database for Larva L1EM dataset"
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ${FILE}"
                            break
                            ;;
                    [Nn]* ) echo "Database l1em not installed."
                            break
                            ;;
                    * ) echo "Please answer yes or no. "
                        ;;
                esac
            done
        else
            echo "Loading Neuroarch database for the Larva L1EM dataset"
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
        while true
        do
            read -p "Download Larva L1EM? (y/N) " -r
            case $REPLY in
                [Yy]* ) if [ -d "l1em" ]
                        then
                        echo
                        while true
                        do
                                read -p "Database $ORIENTDB_DIR/databases/l1em will be overwritten, continue? (y/N) " -r
                                case $REPLY in
                                [Yy]* ) rm -rf l1em/*.*
                                        echo "Downloading Neuroarch database for Larva L1EM dataset"
                                        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1juF2aSp5g-c9S3U3RD9_ydSsDpHaHuLC' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1juF2aSp5g-c9S3U3RD9_ydSsDpHaHuLC" -O l1em.zip && rm -rf /tmp/cookies.txt
                                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ../databases/l1em.zip"
                                        rm l1em.zip
                                        echo "NeuroArch database for Larva L1EM dataset has been installed. The original dataset is licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
                                        break
                                        ;;
                                [Nn]* ) echo "Database L1EM not downloaded."
                                        break
                                        ;;
                                "" )    echo "Database L1EM not downloaded."
                                        break
                                        ;;
                                * ) echo "Please answer yes or no. "
                                        ;;
                                esac
                        done
                        else
                        echo "Downloading Neuroarch database for Larva L1EM dataset"
                        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1juF2aSp5g-c9S3U3RD9_ydSsDpHaHuLC' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1juF2aSp5g-c9S3U3RD9_ydSsDpHaHuLC" -O l1em.zip && rm -rf /tmp/cookies.txt
                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ../databases/l1em.zip"
                        rm l1em.zip
                        echo "NeuroArch database for Larva L1EM dataset has been installed. The original dataset is licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
                        fi
                        break
                        ;;
                [Nn]* ) echo "Database L1EM not downloaded."
                        break
                        ;;
                "" )    echo "Database L1EM not downloaded."
                        break
                        ;;
                * ) echo "Please answer yes or no. "
                ;;
            esac
        done
        break
    else
        read -p "Invalide path, please enter full file path starting with /, otherwise leave blank: " -r FILE
    fi
done

echo