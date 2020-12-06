#!/bin/bash

ORIENTDB_ROOT={ORIENTDB_ROOT}
$ORIENTDB_ROOT/bin/shutdown.sh
tmux kill-session -t db
tmux kill-session -t processor
tmux kill-session -t nlp
tmux kill-session -t neuroarch
