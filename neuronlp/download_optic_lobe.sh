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

read -p "Please enter the full path (starting with /) if you have the optic-lobe dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo
        if [ -d "optic_lobe" ]
        then
            while true
            do
                read -p "Database $ORIENTDB_DIR/databases/optic_lobe will be overwritten, continue? (y/N) " -r
                case $REPLY in
                    [Yy]* ) rm -rf optic_lobe/*.*
                            echo "Loading Neuroarch database for Optic Lobe dataset"
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/optic_lobe admin admin; restore database ${FILE}"
                            break
                            ;;
                    [Nn]* ) echo "Database optic_lobe not installed."
                            break
                            ;;
                    * ) echo "Please answer yes or no. "
                        ;;
                esac
            done
        else
            echo "Loading Neuroarch database for the optic_lobe dataset"
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/optic_lobe admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
        while true
        do
            read -p "Download optic_lobe? (y/N) " -r
            case $REPLY in
                [Yy]* ) if [ -d "optic_lobe" ]
                        then
                        echo
                        while true
                        do
                                read -p "Database $ORIENTDB_DIR/databases/optic_lobe will be overwritten, continue? (y/N) " -r
                                case $REPLY in
                                [Yy]* ) rm -rf optic_lobe/*.*
                                        echo "Downloading Neuroarch database for optic_lobe Optic Lobe dataset"
                                        gdown "1vD7c3rNnqdjtfLk5V2Tk4t-2Z_J4MDcT" -O optic_lobe.zip
                                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/optic_lobe admin admin; restore database ../databases/fioptic_lobeb19.zip"
                                        rm fib19.zip
                                        echo "NeuroArch database for optic_lobe dataset has been installed. The original dataset is provided by HHMI Janelia Research Campus and is licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
                                        break
                                        ;;
                                [Nn]* ) echo "Database optic_lobe not downloaded."
                                        break
                                        ;;
                                "" )    echo "Database optic_lobe not downloaded."
                                        break
                                        ;;
                                * ) echo "Please answer yes or no. "
                                        ;;
                                esac
                        done
                        else
                        echo "Downloading Neuroarch database for optic_lobe dataset"
                        gdown "1vD7c3rNnqdjtfLk5V2Tk4t-2Z_J4MDcT" -O optic_lobe.zip
                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/optic_lobe admin admin; restore database ../databases/optic_lobe.zip"
                        rm optic_lobe.zip
                        echo "NeuroArch database for optic_lobe dataset has been installed. The original dataset is provided by HHMI Janelia Research Campus and is licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
                        fi
                        break
                        ;;
                [Nn]* ) echo "Database optic_lobe not downloaded."
                        break
                        ;;
                "" )    echo "Database optic_lobe not downloaded."
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
