#!/bin/sh
# ASZ's provisioning script
# Started 2023.09.30.6 ~2205 MT at DEN

# TO DO
# - archinstall w/ system-wide packages
# - user-level packages
# - custom repositories
# - setup repository utilities
#

UTILS_DIR="$HOME/.local/bin/"
RCFILE="$HOME/.bashrc"

# Intro
echo "** ASZ provisioning script **"
echo "** THIS VERSION ONLY INSTALLS SETUP REPO UTILITIES **"

## Install custom utilities
echo "** Installing custom utilities **"
mkdir -p $UTILS_DIR
echo "Copying custom utilities to $UTILS_DIR"
cp -r ./bin/* $UTILS_DIR
if [[ ":$PATH:" == *":$UTILS_DIR:"* ]]; then
	echo "$UTILS_DIR already in PATH"
else
	echo "Adding $UTILS_DIR to PATH in $RCFILE"
	echo "export PATH=\"$UTILS_DIR:$PATH\"" >> $RCFILE
	source $RCFILE
fi
