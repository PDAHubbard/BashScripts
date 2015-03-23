#!/bin/bash

# v1
# Tasks
# 1. Backup current dev folder.
# 2. Copy in all from Dropbox folder
# 3. git-add to add any new files to repo
# 4. Start Eclipse-php


DEV_DIR=$HOME/dev/2dbarco.de
DROP_DIR=/media/Data/Dropbox/2dbarcode
BACK_DIR=/media/Data/Dev_tipjar


# 1. Backup current code

echo "Backing up current dev code."
suffix=`eval date +%s`	#the +%s option is GNU specific
prefix=2dbarcode_bak_
filename=$prefix.$suffix
tar -jcf $BACK_DIR/$filename $DEV_DIR


# 2. Copy in all from Dropbox
# TODO: Sync Dropbox folder here as well.

echo "Copying in shared code from Dropbox."
cp -urv $DROP_DIR $DEV_DIR

# 3. Add anything new to git (but don't commit)
echo "Performing git-add of any new files."
cd $DEV_DIR
git add .

# 4. Start Eclipse
#$HOME/dev/scripts/starteclipse.sh & > /dev/null 2>&1

