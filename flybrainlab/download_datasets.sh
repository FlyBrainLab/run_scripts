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

read -p "Please enter the full path (starting with /) if you have the Hemibrain dataset, otherwise leave blank: " -r FILE
while true
do
    if [[ "${FILE// }" == /* ]]
    then
        echo 
        if [ -d "hemibrain" ]
        then
            while true
            do
                read -p "Database $ORIENTDB_DIR/databases/hemibrain will be overwritten, continue? (y/N) " -r
                case $REPLY in
                    [Yy]* ) rm -rf hemibrain/*.*
                            echo "Loading Neuroarch database for Hemibrain dataset"
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ${FILE}"
                            break
                            ;;
                    [Nn]* ) echo "Database hemibrain not installed."
                            break
                            ;;
                    * ) echo "Please answer yes or no. "
                        ;;
                esac
            done
        else
            echo "Loading Neuroarch database for the Hemibrain dataset"
            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ${FILE}"
        fi
        break
    elif [[ -z "${FILE// }" ]]
    then
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
                                            gdown "1ytVmmLrYqKARw9-0tVGJvQzCIzCLUtaN" -O hemibrain.zip
                                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ../databases/hemibrain.zip"
                                            rm hemibrain.zip
                                            echo "NeuroArch database for Hemibrain 1.2 dataset has been installed. The original dataset (https://www.janelia.org/project-team/flyem/hemibrain) is provided by HHMI Janelia Research Campus and is licensed under CC-BY (https://creativecommons.org/licenses/by/4.0/)."
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
                            gdown "1ytVmmLrYqKARw9-0tVGJvQzCIzCLUtaN" -O hemibrain.zip
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/hemibrain admin admin; restore database ../databases/hemibrain.zip"
                            rm hemibrain.zip
                            echo "NeuroArch database for Hemibrain 1.2 dataset has been installed. The original dataset (https://www.janelia.org/project-team/flyem/hemibrain) is provided by HHMI Janelia Research Campus and is licensed under CC-BY (https://creativecommons.org/licenses/by/4.0/)."
                        fi
                        break
                        ;;
                [Nn]* ) echo "Database hemibrain not downloaded."
                        break
                        ;;
                "" ) echo "Database hemibrain not downloaded."
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
                                        gdown "1juF2aSp5g-c9S3U3RD9_ydSsDpHaHuLC" -O l1em.zip
                                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ../databases/l1em.zip"
                                        rm l1em.zip
                                        echo "NeuroArch database for Larva L1EM dataset has been installed. The original dataset (https://doi.org/10.1126/science.add9330) is licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
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
                        gdown "1juF2aSp5g-c9S3U3RD9_ydSsDpHaHuLC" -O l1em.zip
                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/l1em admin admin; restore database ../databases/l1em.zip"
                        rm l1em.zip
                        echo "NeuroArch database for Larva L1EM dataset has been installed. The original dataset (https://doi.org/10.1126/science.add9330) is licensed under CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode)."
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
                                        gdown "1yc929e0fRIcWER5fL1y_z707cNEbV-ti" -O medulla.zip
                                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
                                        rm medulla.zip
                                        echo "NeuroArch database for Medulla 7 column dataset has been installed. The original dataset is provided by HHMI Janelia Research Campus. The license for the original dataset is the following: This data cannot be used for biological discovery or biological publications before Fly EM publishes it. For other purposes (general bio data analysis algorithms, etc), this data is made available under the Open Data Commons Attribution License: http://opendatacommons.org/licenses/by/1.0/."
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
                        gdown "1yc929e0fRIcWER5fL1y_z707cNEbV-ti" -O medulla.zip
                        $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/medulla admin admin; restore database ../databases/medulla.zip"
                        rm medulla.zip
                        echo "NeuroArch database for Medulla 7 column dataset has been installed. The original dataset is provided by HHMI Janelia Research Campus. The license for the original dataset is the following: This data cannot be used for biological discovery or biological publications before Fly EM publishes it. For other purposes (general bio data analysis algorithms, etc), this data is made available under the Open Data Commons Attribution License: http://opendatacommons.org/licenses/by/1.0/."
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
            read -p "Download FlyWire Snapshot630? (y/N) " -r
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
                                            gdown "1S_6qRe7lBIC8vzZvsFAM59ScaMVwx7as" -O flywire.zip
                                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flywire admin admin; restore database ../databases/flywire.zip"
                                            rm flywire.zip
                                            echo "NeuroArch database for FlyWire dataset Snapshot 630 has been installed. The original dataset (https://flywire.ai) is licensed under CC-BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/)."
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
                            gdown "1S_6qRe7lBIC8vzZvsFAM59ScaMVwx7as" -O flywire.zip
                            $ORIENTDB_DIR/bin/console.sh "create database plocal:../databases/flywire admin admin; restore database ../databases/flywire.zip"
                            rm flywire.zip
                            echo "NeuroArch database for FlyWire dataset Snapshot 630 has been installed. The original dataset (https://flywire.ai) is licensed under CC-BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/)."
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

echo

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
