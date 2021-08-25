#!/bin/bash

BINARY_PORT=$(awk -F "=" '/binary-port/ {print $2}' ~/.ffbo/config/config.ini | tr -d ' ')
HTTP_PORT=$(awk -F "=" '/http-port/ {print $2}' ~/.ffbo/config/config.ini | tr -d ' ')
if [ ! -z "$BINARY_PORT" ];
then
    # create a new file to avoid issue with singularity/docker file rewrite/rename restriction

    sed "/protocol=\"binary\"/c\            <listener protocol=\"binary\" socket=\"default\" port-range=\"$BINARY_PORT\" ip-address=\"0.0.0.0\"/>" $ORIENTDB_ROOT/config/orientdb-server-config.xml | tee $ORIENTDB_ROOT/config/test.xml
    cp $ORIENTDB_ROOT/config/test.xml $ORIENTDB_ROOT/config/orientdb-server-config.xml
    rm $ORIENTDB_ROOT/config/test.xml
fi

if [ ! -z "$HTTP_PORT" ];
then
    sed "/protocol=\"http\"/c\            <listener protocol=\"binary\" socket=\"default\" port-range=\"$HTTP_PORT\" ip-address=\"0.0.0.0\"/>" $ORIENTDB_ROOT/config/orientdb-server-config.xml | tee $ORIENTDB_ROOT/config/test.xml
    cp $ORIENTDB_ROOT/config/test.xml $ORIENTDB_ROOT/config/orientdb-server-config.xml
    rm $ORIENTDB_ROOT/config/test.xml
fi

ORIENTDB_ROOT={ORIENTDB_ROOT}
$ORIENTDB_ROOT/bin/server.sh
