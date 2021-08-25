#!/bin/bash

usage() { echo; echo "Usage: $0 -b database_folder_name [-s dataset_name] [-n server_name] [-m mode] [-h]
    -b  the name of the database folder in orientdb/databases to connect to
    -s  the name of the dataset to register with FFBO processor
    -n  the name of this neuroarch server
    -m  mode of database access: 'r' read-only, 'w' read-write, 'o' overwrite (delete the entire database)
    -h  prints this help message
" 1>&2;}

while getopts "hb:n:s:m:" opt; do
  case $opt in
    b)
        if [ -z ${database+x} ];
        then
            database="$OPTARG"
        else
            echo "multiple -b options specified"
            exit 1
        fi
        ;;
    s)
        if [ -z ${dataset+x} ];
        then
            dataset="$OPTARG"
        else
            echo "multiple -s options specified"
            exit 1
        fi
        ;;
    n)
        if [ -z ${name+x} ];
        then
            name="$OPTARG"
        else
            echo "multiple -n options specified"
            exit 1
        fi
        ;;
    m)
        if [ -z ${mode+x} ];
        then
            mode="$OPTARG"
        else
            echo "multiple -m options specified"
            exit 1
        fi
        ;;
    h)
        usage
        exit
        ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        usage
        exit 1
        ;;
  esac
done

if [ -z ${database+x} ];
then
    usage
    exit 1
fi

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV
cd $FFBO_DIR/ffbo.neuroarch_component/neuroarch_component

if [ -z ${mode+x} ];
then
    mode="r"
fi

if [ -z ${dataset+x} ];
then
    dataset=$database
fi

if [ -z ${name+x} ];
then
    name=$database
fi

BINARY_PORT=$(awk -F "=" '/binary-port/ {print $2}' ~/.ffbo/config/config.ini | tr -d ' ')
if [ -z "$BINARY_PORT" ];
then
    python neuroarch_component.py --database $database --dataset $dataset --name $name --mode $mode;
else
    python neuroarch_component.py --port $BINARY_PORT --database $database --dataset $dataset --name $name --mode $mode;
fi


