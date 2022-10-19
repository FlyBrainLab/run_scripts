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

while true
do
    read -p "Download FlyCircuit v1.2? (y/N) " -r
    case $REPLY in
        [Yy]* ) if [ -d "flycircuit" ]
                then
                    echo
                    while true
                    do
                        read -p "Database $ORIENTDB_DIR/databases/flycircuit will be overwritten, continue? (y/N) " -r
                        case $REPLY in
                            [Yy]* ) rm -rf flycircuit/*.*
                                    echo "Downloading Neuroarch database for FlyCircuit dataset"
                                    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1_T-aAqGXh-spuFCWomnEzYnw6WyWUSjq' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1_T-aAqGXh-spuFCWomnEzYnw6WyWUSjq" -O flycircuit.zip && rm -rf /tmp/cookies.txt
                                    $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ../databases/flycircuit.zip"
                                    rm flycircuit.zip
                                    break
                                    ;;
                            [Nn]* ) echo "Database flycircuit not downloaded."
                                    break
                                    ;;
                            "" )    echo "Database flycircuit not downloaded."
                                    break
                                    ;;
                            * ) echo "Please answer yes or no. "
                                ;;
                        esac
                    done
                else
                    echo "Downloading Neuroarch database for FlyCircuit dataset"
                    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1_T-aAqGXh-spuFCWomnEzYnw6WyWUSjq' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1_T-aAqGXh-spuFCWomnEzYnw6WyWUSjq" -O flycircuit.zip && rm -rf /tmp/cookies.txt
                    $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ../databases/flycircuit.zip"
                    rm flycircuit.zip
                fi
                break
                ;;
        [Nn]* ) echo "Database flycircuit not downloaded."
                break
                ;;
        "" )    echo "Database flycircuit not downloaded."
                break
                ;;
        * ) echo "Please answer yes or no. "
            ;;
    esac
done

echo

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

echo

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

echo

