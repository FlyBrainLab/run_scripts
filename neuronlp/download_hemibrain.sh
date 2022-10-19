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
    while true
    do
        read -p "Download datasets to $ORIENTDB_DIR? (Y/n) " -r
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
# prompt to get the path for databases:
#read -p "Please enter the directory where you installed OrientDB (press : " ORIENTDB_DIR

cd $ORIENTDB_DIR/databases

while true
do
    read -p "Download Hemibrain v1.2? (y/N) " -r
    case $REPLY in
        [Yy]* ) if [ -d "hemibrain" ]
                then
                    echo
                    while true
                    do
                        read -p "Database $ORIENTDB_DIR/databases/hemibrain will be overwritten, continue? (y/N) " -r
                        case $REPLY in
                            [Yy]* ) rm -rf hemibrain/*.*
                                    echo "Downloading Neuroarch database for Hemibrain dataset"
                                    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ytVmmLrYqKARw9-0tVGJvQzCIzCLUtaN' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ytVmmLrYqKARw9-0tVGJvQzCIzCLUtaN" -O hemibrain.zip && rm -rf /tmp/cookies.txt
                                    $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ../databases/hemibrain.zip"
                                    rm hemibrain.zip
                                    break
                                    ;;
                            [Nn]* ) echo "Database hemibrain not downloaded."
                                    break
                                    ;;
                            "" )    echo "Database hemibrain not downloaded."
                                    break
                                    ;;
                            * ) echo "Please answer yes or no. "
                                ;;
                        esac
                    done
                else
                    echo "Downloading Neuroarch database for Hemibrain dataset"
                    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ytVmmLrYqKARw9-0tVGJvQzCIzCLUtaN' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ytVmmLrYqKARw9-0tVGJvQzCIzCLUtaN" -O hemibrain.zip && rm -rf /tmp/cookies.txt
                    $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ../databases/hemibrain.zip"
                    rm hemibrain.zip
                fi
                break
                ;;
        [Nn]* ) echo "Database hemibrain not downloaded."
                break
                ;;
        "" )    echo "Database hemibrain not downloaded."
                break
                ;;
        * ) echo "Please answer yes or no. "
            ;;
    esac
done

echo
