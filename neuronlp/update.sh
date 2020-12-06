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

cd $FFBO_DIR/quepy
git pull
