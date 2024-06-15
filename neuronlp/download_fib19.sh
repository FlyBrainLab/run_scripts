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

cd $ORIENTDB_DIR/databases

read -p "Please enter the full path (starting with /) if you have the FIB19 Optic Lobe dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo
        if [ -d "fib19" ]
        then
            while true
            do
                read -p "Database $ORIENTDB_DIR/databases/fib19 will be overwritten, continue? (y/N) " -r
                case $REPLY in
                    [Yy]* ) rm -rf fib19/*.*
                            echo "Loading Neuroarch database for FIB19 Optic Lobe dataset"
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/fib19 admin admin; restore database ${FILE}"
                            break
                            ;;
                    [Nn]* ) echo "Database fib19 not installed."
                            break
                            ;;
                    * ) echo "Please answer yes or no. "
                        ;;
                esac
            done
        else
            echo "Loading Neuroarch database for the FIB19 Optic Lobe dataset"
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/fib19 admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
        while true
        do
            read -p "Download FIB19 Optic Lobe? (y/N) " -r
            case $REPLY in
                [Yy]* ) if [ -d "fib19" ]
                        then
                        echo
                        while true
                        do
                                read -p "Database $ORIENTDB_DIR/databases/fib19 will be overwritten, continue? (y/N) " -r
                                case $REPLY in
                                [Yy]* ) rm -rf fib19/*.*
                                        echo "Downloading Neuroarch database for FIB19 Optic Lobe dataset"
                                        gdown "11TJlrASgf6HlhLNrnoAZ8trd8cbcToOM" -O fib19.zip
                                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/fib19 admin admin; restore database ../databases/fib19.zip"
                                        rm fib19.zip
                                        echo "NeuroArch database for FIB19 Optic Lobe dataset has been installed. The original dataset is provided by HHMI Janelia Research Campus and is licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
                                        break
                                        ;;
                                [Nn]* ) echo "Database FIB19 not downloaded."
                                        break
                                        ;;
                                "" )    echo "Database FIB19 not downloaded."
                                        break
                                        ;;
                                * ) echo "Please answer yes or no. "
                                        ;;
                                esac
                        done
                        else
                        echo "Downloading Neuroarch database for FIB19 Optic Lobe dataset"
                        gdown "11TJlrASgf6HlhLNrnoAZ8trd8cbcToOM" -O fib19.zip
                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/fib19 admin admin; restore database ../databases/fib19.zip"
                        rm fib19.zip
                        echo "NeuroArch database for FIB19 Optic Lobe dataset has been installed. The original dataset is provided by HHMI Janelia Research Campus and is  licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
                        fi
                        break
                        ;;
                [Nn]* ) echo "Database FIB19 not downloaded."
                        break
                        ;;
                "" )    echo "Database FIB19 not downloaded."
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
