#!/bin/bash

set -e

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV

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
# prompt to get the path for databases:
#read -p "Please enter the directory where you installed OrientDB (press : " ORIENTDB_DIR

cd $ORIENTDB_DIR/databases

read -p "Please enter the full path (starting with /)  if you have the FlyCircuit dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo
        if [ -d "flycircuit" ]
        then
                while true
                do
                read -p "Database $ORIENTDB_DIR/databases/flycircuit will be overwritten, continue? (y/N) " -r
                case $REPLY in
                        [Yy]* ) rm -rf flycircuit/*.*
                                echo "Loading Neuroarch database for FlyCircuit dataset"
                                $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ${FILE}"
                                break
                                ;;
                        [Nn]* ) echo "Database flycircuit not installed."
                                break
                                ;;
                        * ) echo "Please answer yes or no. "
                        ;;
                esac
                done
        else
                echo "Loading Neuroarch database for the FlyCircuit dataset"
                $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
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
                                        gdown "1_T-aAqGXh-spuFCWomnEzYnw6WyWUSjq" -O flycircuit.zip
                                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ../databases/flycircuit.zip"
                                        rm flycircuit.zip
                                        echo "NeuroArch database for FlyCircuit dataset has been installed. The original dataset can be found here (http://flycircuit.tw/)."
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
                        gdown "1_T-aAqGXh-spuFCWomnEzYnw6WyWUSjq" -O flycircuit.zip
                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flycircuit admin admin; restore database ../databases/flycircuit.zip"
                        rm flycircuit.zip
                        echo "NeuroArch database for FlyCircuit dataset has been installed. The original dataset can be found here (http://flycircuit.tw/)."
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
        break
    else
        read -p "Invalide path, please enter full file path starting with /, otherwise leave blank: " -r FILE
    fi
done

echo
