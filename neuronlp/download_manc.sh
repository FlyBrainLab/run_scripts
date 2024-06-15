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

read -p "Please enter the full path (starting with /) if you have the MANC dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo 
        if [ -d "manc" ]
        then
            while true
            do
                read -p "Database $ORIENTDB_DIR/databases/manc will be overwritten, continue? (y/N) " -r
                case $REPLY in
                    [Yy]* ) rm -rf manc/*.*
                            echo "Loading Neuroarch database for MANC dataset"
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/manc admin admin; restore database ${FILE}"
                            break
                            ;;
                    [Nn]* ) echo "Database manc not installed."
                            break
                            ;;
                    * ) echo "Please answer yes or no. "
                        ;;
                esac
            done
        else
            echo "Loading Neuroarch database for the MANC dataset"
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/manc admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
        while true
        do
            read -p "Download MANC v1.0? (y/N) " -r
            case $REPLY in
                [Yy]* ) if [ -d "manc" ]
                        then
                            echo
                            while true
                            do
                                read -p "Database $ORIENTDB_DIR/databases/manc will be overwritten, continue? (y/N) " -r
                                case $REPLY in
                                    [Yy]* ) rm -rf manc/*.*
                                            echo "Downloading Neuroarch database for MANC dataset"
                                            gdown "15MgSmFMFl_vUtS32rVpb0E7HKpJAQe8v" -O manc.zip
                                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/manc admin admin; restore database ../databases/manc.zip"
                                            rm manc.zip
                                            echo "NeuroArch database for MANC 1.0 has been installed. The original dataset (https://www.janelia.org/project-team/flyem/manc-connectome) is provided by HHMI Janelia Research Campus and is licensed under CC-BY (https://creativecommons.org/licenses/by/4.0/)."
                                            break
                                            ;;
                                    [Nn]* ) echo "Database manc not downloaded."
                                            break
                                            ;;
                                    "" )    echo "Database manc not downloaded."
                                            break
                                            ;;
                                    * ) echo "Please answer yes or no. "
                                        ;;
                                esac
                            done
                        else
                            echo "Downloading Neuroarch database for MANC dataset"
                            gdown "15MgSmFMFl_vUtS32rVpb0E7HKpJAQe8v" -O manc.zip
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/manc admin admin; restore database ../databases/manc.zip"
                            rm manc.zip
                            echo "NeuroArch database for MANC 1.0 has been installed. The original dataset (https://www.janelia.org/project-team/flyem/manc-connectome) is provided by HHMI Janelia Research Campus and is licensed under CC-BY (https://creativecommons.org/licenses/by/4.0/)."
                        fi
                        break
                        ;;
                [Nn]* ) echo "Database manc not downloaded."
                        break
                        ;;
                "" ) echo "Database manc not downloaded."
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
