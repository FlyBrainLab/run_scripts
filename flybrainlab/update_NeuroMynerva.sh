#!/bin/bash

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV

cd $FFBO_DIR/NeuroMynerva
git pull
jupyter lab clean
jlpm run upgrade neu3d
jlpm
jlpm run build
jupyter labextension install .
