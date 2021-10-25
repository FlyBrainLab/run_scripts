#!/bin/bash


CONDA_ROOT=$(conda info --base)
CROSSBAR_ENV={CROSSBAR_ENV}
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh

conda activate $CROSSBAR_ENV

cd $FFBO_DIR/ffbo.processor
git pull
python -m pip install -e .

conda deactivate
conda activate $FFBO_ENV

python -m pip install --upgrade git+https://github.com/fruitflybrain/ffbo.neuroarch_nlp.git git+https://github.com/fruitflybrain/quepy.git

cd $FFBO_DIR/ffbo.nlp_component
git pull
python -m pip install -e .

cd $FFBO_DIR/ffbo.neuroarch_component
git pull
python -m pip install -e .

python -m pip install --upgrade neuroarch

conda deactivate

cd $FFBO_DIR/ffbo.neuronlp
git checkout -f
git pull

cd $FFBO_DIR/ffbo.neuronlp/lib
git checkout -f
git pull
