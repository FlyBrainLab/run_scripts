#!/bin/bash

FFBO_DIR={FFBO_DIR}
ORIENTDB_ROOT={ORIENTDB_ROOT}


tmux new-session -d -s "db" $FFBO_DIR/bin/run_database.sh

tmux new-session -d -s "processor" $FFBO_DIR/bin/run_processor.sh
sleep 20
if [ -d "$ORIENTDB_ROOT/databases/hemibrain" ]
then
    tmux new-session -d -s "nlp_hemibrain" $FFBO_DIR/bin/run_nlp.sh -b hemibrain
    tmux new-session -d -s "neuroarch_hemibrain" $FFBO_DIR/bin/run_neuroarch.sh -a hemibrain
fi

if [ -d "$ORIENTDB_ROOT/databases/flycircuit" ]
then
    tmux new-session -d -s "nlp_flycircuit" $FFBO_DIR/bin/run_nlp.sh -b flycircuit
    tmux new-session -d -s "neuroarch_flycircuit" $FFBO_DIR/bin/run_neuroarch.sh -a flycircuit
fi

if [ -d "$ORIENTDB_ROOT/databases/l1em" ]
then
    tmux new-session -d -s "nlp_l1em" $FFBO_DIR/bin/run_nlp.sh -b l1em
    tmux new-session -d -s "neuroarch_l1em" $FFBO_DIR/bin/run_neuroarch.sh -a l1em
fi

if [ -d "$ORIENTDB_ROOT/databases/medulla" ]
then
    tmux new-session -d -s "nlp_medulla" $FFBO_DIR/bin/run_nlp.sh -b medulla
    tmux new-session -d -s "neuroarch_medulla" $FFBO_DIR/bin/run_neuroarch.sh -a medulla
fi

tmux new-session -d -s "neurokernel" $FFBO_DIR/bin/run_neurokernel.sh

echo "Servers started. Check tmux sessions for status. To shutdown, run $FFBO_DIR/bin/shutdown.sh"

cd $FFBODIR
# Starting FlyBrainLab
$FFBO_DIR/bin/run_fbl.sh

$FFBO_DIR/bin/shutdown.sh
