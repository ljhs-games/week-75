#!/bin/bash

EXPORT_FOLDER=exports

# Guide through exporting game

check_for() {
    echo "Checking for $1 ..."
    if ! [ "$(command -v $1)" ]; then
        echo "$1 not found! Exiting ..."
        exit 1
    fi
}

check_for "xclip"
check_for "zip"
check_for "rm"
check_for "pwd"

echo "Checking for $EXPORT_FOLDER directory..."
if ! [ -d "$EXPORT_FOLDER" ]; then
    echo "$EXPORT_FOLDER directory not found! Exiting ..."
    exit 1
fi

echo "Deleting $EXPORT_FOLDER/* ..."
rm -r $EXPORT_FOLDER/*
cd "$EXPORT_FOLDER"
echo "Copying $EXPORT_FOLDER path to clipboard ..."
pwd | xclip -selection c
echo "Please export game to path in clipboard, then press any key to continue ..."
read -n1 -s
read -p "Game Name   : " GAME_NAME
read -p "Export Type : " EXPORT_TYPE
read -p "Version     : " GAME_VERSION
zip "${GAME_NAME}-${EXPORT_TYPE}v${GAME_VERSION}.zip" *
echo "Done"
