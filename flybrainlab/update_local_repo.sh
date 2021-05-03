#!/bin/bash

CONDA_ROOT=$(conda info --base)
CROSSBAR_ENV={CROSSBAR_ENV}
NLP_ENV={NLP_ENV}
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $NLP_ENV

cd $FFBO_DIR/ffbo.neuroarch_nlp
git pull
python setup.py develop

cd $FFBO_DIR/ffbo.nlp_component
git pull
python setup.py develop

conda deactivate
conda activate $CROSSBAR_ENV

cd $FFBO_DIR/ffbo.processor
git pull
python setup.py develop

conda deactivate
conda activate $FFBO_ENV

cd $FFBO_DIR/neuroarch
git pull
python setup.py develop

cd $FFBO_DIR/ffbo.neuroarch_component
git pull
python setup.py develop

cd $FFBO_DIR/neurokernel
git pull
python setup.py develop
cd $FFBO_DIR/neurodriver
git pull
python setup.py develop
cd $FFBO_DIR/ffbo.neurokernel_component
git pull
python setup.py develop

cd $FFBO_DIR/Neuroballad
git pull
python setup.py develop
cd $FFBO_DIR/FBLClient
git pull
python setup.py develop
cd $FFBO_DIR/NeuroMynerva
git pull
pip install -e .
jupyter labextension develop . --overwrite
jlpm run build

conda deactivate
