#!/bin/bash

ORIENTDB_ROOT={ORIENTDB_ROOT}
BINARY_PORT=$(awk -F "=" '/binary-port/ {print $2}' ~/.ffbo/config/config.ini | tr -d ' ')
if [ -z "$BINARY_PORT" ];
then
    $ORIENTDB_ROOT/bin/shutdown.sh -u root -p root;
else
    $ORIENTDB_ROOT/bin/shutdown.sh -P $BINARY_PORT -u root -p root;
fi

tmux kill-session -t db
tmux kill-session -t processor
tmux kill-session -t nlp_hemibrain
tmux kill-session -t nlp_flycircuit
tmux kill-session -t nlp_l1em
tmux kill-session -t nlp_medulla
tmux kill-session -t neuroarch_hemibrain
tmux kill-session -t neuroarch_flycircuit
tmux kill-session -t neuroarch_l1em
tmux kill-session -t neuroarch_medulla
tmux kill-session -t neurokernel
