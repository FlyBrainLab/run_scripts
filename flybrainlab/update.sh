#!/bin/bash

FFBO_DIR={FFBO_DIR}

cd $FFBO_DIR/ffbo.nlp_component
git pull

cd $FFBO_DIR/ffbo.neuroarch_nlp
git pull

cd $FFBO_DIR/ffbo.processor
git pull

cd $FFBO_DIR/ffbo.neuroarch_component
git pull

cd $FFBO_DIR/neuroarch
git pull

cd $FFBO_DIR/neurokernel
git pull

cd $FFBO_DIR/neurodriver
git pull

cd $FFBO_DIR/retina
git pull

cd $FFBO_DIR/Neuroballad
git pull

cd $FFBO_DIR/FBLClient
git pull
