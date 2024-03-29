#!/bin/bash
CONDA_ROOT=$(conda info --base)
FFBO_ENV={FFBO_ENV}
FFBO_DIR={FFBO_DIR}

. $CONDA_ROOT/etc/profile.d/conda.sh
conda activate $FFBO_ENV
cd $FFBO_DIR/nk_tmp
export OMPI_MCA_btl_tcp_if_include=lo
python $FFBO_DIR/ffbo.neurokernel_component/neurokernel_component/neurokernel_component.py
