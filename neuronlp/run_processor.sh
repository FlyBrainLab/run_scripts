#!/bin/bash

CONDA_ROOT=$(conda info --base)
CROSSBAR_ENV={CROSSBAR_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh

conda activate $CROSSBAR_ENV
cd $FFBO_DIR/ffbo.processor
python config.py
cd components
crossbar start --config docker_config.json
