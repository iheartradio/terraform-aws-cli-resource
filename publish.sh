#!/bin/bash

set -e
if [[ -z $1 ]]; then
    echo "Missing version bump argument.  Need one of 'major', 'minor' or 'snapshot'"
    exit 1
fi

BUMPTYPE=$1

./version_bump.sh $BUMPTYPE
NEW_VER=$(cat ./VERSION)
git add VERSION
git commit -m "setting version to $NEW_VER"
git tag -a v$NEW_VER -m "v$NEW_VER"
./version_bump.sh snapshot
NEW_SNAPSHOT_VER=$(cat ./VERSION)
git add VERSION
git commit -m "setting version to $NEW_SNAPSHOT_VER"
git push && git push --tags
set +e