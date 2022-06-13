#!/bin/bash

FFBO_DIR={FFBO_DIR}

tmux new-session -d -s "db" $FFBO_DIR/bin/run_database.sh

tmux new-session -d -s "processor" $FFBO_DIR/bin/run_processor.sh
sleep 30
tmux new-session -d -s "nlp" "$FFBO_DIR/bin/run_nlp.sh -a $1 -b"
tmux new-session -d -s "neuroarch" "$FFBO_DIR/bin/run_neuroarch.sh -b $1"

echo "Servers started. Check tmux sessions for status. To shutdown, run ~/ffbo/bin/shutdown.sh"

read -r -d '' _ </dev/tty
