#!/bin/bash

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV
cd $FFBO_DIR/ffbo.neuroarch_component/neuroarch_component

if [ $# -eq 0 ]; then
    python neuroarch_component.py --database hemibrain --dataset hemibrain --name hemibrain_v1.0.1
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
