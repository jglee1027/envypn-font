#!/usr/bin/env bash

SCRIPT_NAME=$(basename $0)

LOCAL_FONT_DIR="$HOME/.local/share/fonts/envypn"
GLOBAL_FONT_DIR="/usr/share/fonts/envypn"

if [ "$1" == "" ]; then
    echo "SYNOPSIS"
    echo "   $SCRIPT_NAME [-l|-g]"
    echo "EXAMPLE"
    echo "   $ $SCRIPT_NAME -l : to install $LOCAL_FONT_DIR"
    echo "   $ $SCRIPT_NAME -g : to install $GLOBAL_FONT_DIR"
    exit 1
fi


if [ "$1" == "-l" ]; then
    FONT_DIR=$LOCAL_FONT_DIR
elif [ "$1" == "-g" ]; then
    FONT_DIR=$GLOBAL_FONT_DIR
else
    echo "error: invalid parameter "
    exit 2
fi

mkdir -p "$FONT_DIR"
if [ ! -w "$FONT_DIR" ]; then
    echo "error: no write permission in $FONT_DIR"
    exit 3
fi

echo "---cp---"
cp -v *.bdf fonts.* "$FONT_DIR"

if [ $? -ne 0 ]; then
    echo "error: cannot copy font files to \"$FONT_DIR\""
    exit 4
fi

echo "---fc-cache---"
fc-cache -fv "$FONT_DIR"
mkfontdir "$FONT_DIR"

echo
echo "envypn is successfully installed!!!"
