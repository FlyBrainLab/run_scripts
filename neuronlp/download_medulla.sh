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

read -p "Please enter the full path (starting with /)  if you have the Medulla dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo
        if [ -d "medulla" ]
        then
            while true
            do
                read -p "Database $ORIENTDB_DIR/databases/medulla will be overwritten, continue? (y/N) " -r
                case $REPLY in
                    [Yy]* ) rm -rf medulla/*.*
                            echo "Loading Neuroarch database for Medulla dataset"
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ${FILE}"
                            break
                            ;;
                    [Nn]* ) echo "Database medulla not installed."
                            break
                            ;;
                    * ) echo "Please answer yes or no. "
                        ;;
                esac
            done
        else
            echo "Loading Neuroarch database for the Medulla dataset"
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
        while true
        do
            read -p "Download Medulla 7 Column? (y/N) " -r
            case $REPLY in
                [Yy]* ) if [ -d "medulla" ]
                        then
                        echo
                        while true
                        do
                                read -p "Database $ORIENTDB_DIR/databases/medulla will be overwritten, continue? (y/N) " -r
                                case $REPLY in
                                [Yy]* ) rm -rf medulla/*.*
                                        echo "Downloading Neuroarch database for Medulla 7 Column dataset"
                                        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti" -O medulla.zip && rm -rf /tmp/cookies.txt
                                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
                                        rm medulla.zip
                                        break
                                        ;;
                                [Nn]* ) echo "Database medulla not downloaded."
                                        break
                                        ;;
                                "" )    echo "Database medulla not downloaded."
                                        break
                                        ;;
                                * ) echo "Please answer yes or no. "
                                        ;;
                                esac
                        done
                        else
                        echo "Downloading Neuroarch database for Medulla 7 Column dataset"
                        wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1yc929e0fRIcWER5fL1y_z707cNEbV-ti" -O medulla.zip && rm -rf /tmp/cookies.txt
                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
                        rm medulla.zip
                        fi
                        break
                        ;;
                [Nn]* ) echo "Database medulla not downloaded."
                        break
                        ;;
                "" )    echo "Database medulla not downloaded."
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
