#!/bin/bash

# Everything is this script is bad practice! Do as I say not as I do!

set -eu
set -o pipefail

declare -A REALHASH

git init  # create empty repo
git remote add origin git@github.com:Ry4an/unbreaking-git.git

# add this script
git add create.sh README.md

# create master branch commits
for FAKEHASH in deadbeef debac1e 0b57ac1e dec0ded ca55e77e ca5caded ; do
    echo Committed as ${FAKEHASH} >| a_file
    git add a_file
    git commit -m "Pretend I'm ${FAKEHASH}"
    REALHASH[$FAKEHASH]=$(git rev-parse HEAD)
done
git push -f origin master

# create D131 branch commits
git branch D131 ${REALHASH[deadbeef]}
git checkout D131
for FAKEHASH in fe1afe1 decafbad ; do
    echo Committed as ${FAKEHASH} >| a_file
    git add a_file
    git commit -m "Pretend I'm ${FAKEHASH}"
    REALHASH[$FAKEHASH]=$(git rev-parse HEAD)
done
git push -f origin D131

# create D132 branch commits
git branch D132 ${REALHASH[0b57ac1e]}
git checkout D132
for FAKEHASH in b01dface f005ba11 ; do
    echo Committed as ${FAKEHASH} >| a_different_file
    git add a_different_file
    git commit -m "Pretend I'm ${FAKEHASH}"
    REALHASH[$FAKEHASH]=$(git rev-parse HEAD)
done
git push -f origin D132

