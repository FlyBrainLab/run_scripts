#!/bin/bash

usage() { echo; echo "Usage: $0 -a app_name [-s dataset_name] [-n server_name] [-b] [-h]
    -a  the name of application
    -s  the name of the dataset to register with FFBO processor
    -n  the name of this nlp server
    -b  run drosobot
    -h  prints this help message
" 1>&2;}

extra_args=""

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV
cd $FFBO_DIR/ffbo.nlp_component/nlp_component

while getopts "ha:n:s:b" opt; do
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
    b)
        if python -c "import drosobot" > /dev/null 2>&1;
        then
            extra_args="--drosobot";
        else
            echo "DrosoBOT not installed. Running NLP server without DrosoBOT."
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



if [ -z ${dataset+x} ];
then
    dataset=$app
fi

if [ -z ${name+x} ];
then
    name=$app
fi

python nlp_component.py --app $app --dataset $dataset --name $name $extra_args
