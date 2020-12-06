#!/bin/bash

CONDA_ROOT=$(conda info --base)
NLP_ENV={NLP_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $NLP_ENV
cd $FFBO_DIR/ffbo.nlp_component/nlp_component

# Defaults to hemibrain app
if [ $# -eq 0 ]; then
    python nlp_component.py
fi

if [ $# -eq 1 ]; then
    python nlp_component.py --app $1
fi
