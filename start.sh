#!/bin/bash

if [[ -n $RCLONE_CONFIG && -n $RCLONE_DESTINATION ]]; then
    echo "Rclone config detected"
    echo -e "$RCLONE_CONFIG" > rclone.conf
    echo "on-download-stop=./delete.sh" >> aria2c.conf
    echo "on-download-complete=./on-complete.sh" >> aria2c.conf
    chmod +x delete.sh
    chmod +x on-complete.sh
fi
{
    eval $RCLONE_SYNC_COMMAND
}&

echo "rpc-secret=$ARIA2C_SECRET" >> aria2c.conf
aria2c --conf-path=aria2c.conf&
yarn start
