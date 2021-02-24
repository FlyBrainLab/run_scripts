#!/bin/bash

CONDA_ROOT=$(conda info --base)
NLP_ENV={NLP_ENV}
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $NLP_ENV

cd $FFBO_DIR/ffbo.nlp_component
git pull
python setup.py develop

pip install git+https://github.com/fruitflybrain/ffbo.neuroarch_nlp.git

conda deactivate
conda activate $FFBO_ENV

cd $FFBO_DIR/ffbo.processor
git pull
python setup.py develop

cd $FFBO_DIR/ffbo.neuroarch_component
git pull
python setup.py develop

pip install --upgrade neuroarch
pip install --upgrade neurokernel
pip install --upgrade neurodriver

cd $FFBO_DIR/retina
git pull
python setup.py develop

pip install git+https://github.com/flybrainlab/Neuroballad.git
pip install --upgrade flybrainlab
pip install --upgrade neuromynerva

conda deactivate
