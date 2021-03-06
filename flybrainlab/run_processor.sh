#!/bin/bash

CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh

conda activate $FFBO_ENV
cd $FFBO_DIR/ffbo.neuronlp
git checkout js/NeuroNLP.js
sleep 2
cd $FFBO_DIR/ffbo.processor
python config.py
cd components
crossbar start --config docker_config.json
