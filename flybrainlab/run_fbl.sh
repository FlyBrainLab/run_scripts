#!/bin/bash

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV
cd $FFBO_DIR
jupyter lab --ip 0.0.0.0 --ServerApp.iopub_data_rate_limit=10000000000
