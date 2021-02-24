#!/bin/bash

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV
cd $FFBO_DIR/ffbo.neuroarch_component/neuroarch_component

if [ $# -eq 0 ]; then
    echo Usage:
    echo ./run_neuroarch.sh database_folder_name [dataset_name] [server_name]
    echo example: ./run_neuroarch.sh hemibrain
    echo          ./run_neuroarch.sh flycircuit flycircuit flycircuit1.2
    exit 0
fi

if [ $# -eq 1 ]; then
    python neuroarch_component.py --database $1 --dataset $1 --name $1
fi

if [ $# -eq 2 ]; then
    python neuroarch_component.py --database $1 --dataset $2 --name $2
fi

if [ $# -eq 3 ]; then
    python neuroarch_component.py --database $1 --dataset $2 --name $3
fi
