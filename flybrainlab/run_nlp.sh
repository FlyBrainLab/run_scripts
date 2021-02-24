#!/bin/bash

CONDA_ROOT=$(conda info --base)
NLP_ENV={NLP_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $NLP_ENV
cd $FFBO_DIR/ffbo.nlp_component/nlp_component

# Defaults to hemibrain app
if [ $# -eq 0 ]; then
    echo Usage:
    echo ./run_nlp.sh app_name [dataset_name] [server_name]
    echo example: ./run_nlp.sh hemibrain
    echo          ./run_nlp.sh flycircuit flycircuit flycircuit1.2
    exit 0
fi

if [ $# -eq 1 ]; then
    python nlp_component.py --app $1
fi

if [ $# -eq 2 ]; then
    python nlp_component.py --app $1 --dataset $2
fi

if [ $# -eq 3 ]; then
    python nlp_component.py --app $1 --dataset $2 --name $3
fi
