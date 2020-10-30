#!/bin/bash

ORIENTDB_ROOT={ORIENTDB_ROOT}
FFBO_DIR={FFBO_DIR}

tmux new-session -d -s "db" $ORIENTDB_ROOT/bin/server.sh

tmux new-session -d -s "processor" $FFBO_DIR/bin/run_processor.sh
tmux new-session -d -s "nlp_hemibrain" $FFBO_DIR/bin/run_nlp.sh hemibrain
tmux new-session -d -s "nlp_flycircuit" $FFBO_DIR/bin/run_nlp.sh flycircuit
tmux new-session -d -s "nlp_l1em" $FFBO_DIR/bin/run_nlp.sh l1em
sleep 20
tmux new-session -d -s "neuroarch_hemibrain" $FFBO_DIR/bin/run_neuroarch.sh hemibrain
tmux new-session -d -s "neuroarch_flycircuit" $FFBO_DIR/bin/run_neuroarch.sh flycircuit
tmux new-session -d -s "neuroarch_l1em" $FFBO_DIR/bin/run_neuroarch.sh l1em
tmux new-session -d -s "neurokernel" $FFBO_DIR/bin/run_neurokernel.sh

echo "Servers started. Check tmux sessions for status. To shutdown, run $FFBO_DIR/bin/shutdown.sh"

# Starting FlyBrainLab
$FFBO_DIR/bin/run_fbl.sh
