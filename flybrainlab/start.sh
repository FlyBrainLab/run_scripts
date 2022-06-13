#!/bin/bash

FFBO_DIR={FFBO_DIR}
ORIENTDB_ROOT={ORIENTDB_ROOT}


tmux new-session -d -s "db" $FFBO_DIR/bin/run_database.sh

tmux new-session -d -s "processor" $FFBO_DIR/bin/run_processor.sh
sleep 30
if [ -d "$ORIENTDB_ROOT/databases/hemibrain" ]
then
    tmux new-session -d -s "nlp_hemibrain" "$FFBO_DIR/bin/run_nlp.sh -a hemibrain -b"
    tmux new-session -d -s "neuroarch_hemibrain" "$FFBO_DIR/bin/run_neuroarch.sh -b hemibrain"
fi

if [ -d "$ORIENTDB_ROOT/databases/flycircuit" ]
then
    tmux new-session -d -s "nlp_flycircuit" "$FFBO_DIR/bin/run_nlp.sh -a flycircuit"
    tmux new-session -d -s "neuroarch_flycircuit" "$FFBO_DIR/bin/run_neuroarch.sh -b flycircuit"
fi

if [ -d "$ORIENTDB_ROOT/databases/l1em" ]
then
    tmux new-session -d -s "nlp_l1em" "$FFBO_DIR/bin/run_nlp.sh -a l1em"
    tmux new-session -d -s "neuroarch_l1em" "$FFBO_DIR/bin/run_neuroarch.sh -b l1em"
fi

if [ -d "$ORIENTDB_ROOT/databases/medulla" ]
then
    tmux new-session -d -s "nlp_medulla" "$FFBO_DIR/bin/run_nlp.sh -a medulla"
    tmux new-session -d -s "neuroarch_medulla" "$FFBO_DIR/bin/run_neuroarch.sh -b medulla"
fi

tmux new-session -d -s "neurokernel" $FFBO_DIR/bin/run_neurokernel.sh

echo "Servers started. Check tmux sessions for status. To shutdown, run $FFBO_DIR/bin/shutdown.sh"

cd $FFBODIR
# Starting FlyBrainLab
$FFBO_DIR/bin/run_fbl.sh

$FFBO_DIR/bin/shutdown.sh
