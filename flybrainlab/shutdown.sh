#!/bin/bash

ORIENTDB_ROOT={ORIENTDB_ROOT}
$ORIENTDB_ROOT/bin/shutdown.sh -P {ORIENTDB_BINARY_PORT} -u root -p root
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
