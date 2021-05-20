#!/bin/bash

usage() { echo; echo "Usage: $0 -a app_name [-s dataset_name] [-n server_name] [-h]
    -a  the name of application
    -s  the name of the dataset to register with FFBO processor
    -n  the name of this nlp server
    -h  prints this help message
" 1>&2;}

while getopts "ha:n:s:" opt; do
  case $opt in
    a)
        if [ -z ${app+x} ];
        then
            app="$OPTARG"
        else
            echo "multiple -a options specified"
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

if [ -z ${app+x} ];
then
    usage
    exit 1
fi

CONDA_ROOT=$(conda info --base)
NLP_ENV={NLP_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $NLP_ENV
cd $FFBO_DIR/ffbo.nlp_component/nlp_component

if [ -z ${dataset+x} ];
then
    dataset=$app
fi

if [ -z ${name+x} ];
then
    name=$app
fi

python nlp_component.py --app $app --dataset $dataset --name name
