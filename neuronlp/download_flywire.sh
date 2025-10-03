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

read -p "Please enter the full path (starting with /) if you have the FlyWire dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo 
        if [ -d "flywire" ]
        then
            while true
            do
                read -p "Database $ORIENTDB_DIR/databases/flywire will be overwritten, continue? (y/N) " -r
                case $REPLY in
                    [Yy]* ) rm -rf flywire/*.*
                            echo "Loading Neuroarch database for FlyWire dataset"
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flywire admin admin; restore database ${FILE}"
                            break
                            ;;
                    [Nn]* ) echo "Database flywire not installed."
                            break
                            ;;
                    * ) echo "Please answer yes or no. "
                        ;;
                esac
            done
        else
            echo "Loading Neuroarch database for the FlyWire dataset"
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flywire admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
        while true
        do
            read -p "Download FlyWire Snapshot783? (y/N) " -r
            case $REPLY in
                [Yy]* ) if [ -d "flywire" ]
                        then
                            echo
                            while true
                            do
                                read -p "Database $ORIENTDB_DIR/databases/flywire will be overwritten, continue? (y/N) " -r
                                case $REPLY in
                                    [Yy]* ) rm -rf flywire/*.*
                                            echo "Downloading Neuroarch database for FlyWire dataset"
                                            gdown "1Tcc_WzaAMJUD99j9fBKIj6cWrC1RX-cQ" -O flywire.zip
                                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flywire admin admin; restore database ../databases/flywire.zip"
                                            rm flywire.zip
                                            echo "NeuroArch database for FlyWire dataset Snapshot 783 has been installed. The original dataset (https://flywire.ai) is licensed under CC-BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/)."
                                            break
                                            ;;
                                    [Nn]* ) echo "Database flywire not downloaded."
                                            break
                                            ;;
                                    "" )    echo "Database flywire not downloaded."
                                            break
                                            ;;
                                    * ) echo "Please answer yes or no. "
                                        ;;
                                esac
                            done
                        else
                            echo "Downloading Neuroarch database for FlyWire dataset"
                            gdown "1Tcc_WzaAMJUD99j9fBKIj6cWrC1RX-cQ" -O flywire.zip
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flywire admin admin; restore database ../databases/flywire.zip"
                            rm flywire.zip
                            echo "NeuroArch database for FlyWire dataset Snapshot 783 has been installed. The original dataset (https://flywire.ai) is licensed under CC-BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/)."
                        fi
                        break
                        ;;
                [Nn]* ) echo "Database flywire not downloaded."
                        break
                        ;;
                "" ) echo "Database flywire not downloaded."
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

