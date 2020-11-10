#!/bin/bash
shopt -s nocasematch

if [[ -z $1 ]]; then
    echo "Missing version bump argument.  Need one of 'major', 'minor' or 'snapshot'"
    exit 1
fi

OPERATION=$1
VERSION_REGEX="^([0-9]+)\.([0-9]+)(-SNAPSHOT)?$"

if [[ $(cat ./VERSION) =~ $VERSION_REGEX ]]
then
    major="${BASH_REMATCH[1]}"
    minor="${BASH_REMATCH[2]}"
    current_version="$major.$minor"

    if [[ "$OPERATION" == "major" ]]
    then
    	next_version="$((major+1)).0"

    elif [[ "$OPERATION" == "minor" ]]
    then
    	next_version="$major.$((minor))"

    elif [[ "$OPERATION" == "snapshot" ]]
    then
        next_version="$major.$((minor+1))-SNAPSHOT"

    else
    	echo "Invalid operation: $OPERATION. Must be either 'major', 'minor' or 'snapshot'"
    	exit 1
    fi

    echo "Applying change $current_version -> $next_version"
    echo "$next_version" > ./VERSION
else
    echo "./VERSION isn't a valid version file" >&2
fi