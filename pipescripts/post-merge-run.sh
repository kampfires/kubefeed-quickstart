#!/bin/bash

## Prepare Working Directory

### create directory for working clone used to process script updates
mkdir /workspace/pr$PULL_NUMBER
git clone $SOURCE_URL
cd $APP_NAME

## Execute commands that do not make or require changes that be merged back into the repo

### run kubectl delete on the files in the delete/ directory
kubectl delete -f delete/

### run kubectly apply on the files in the manifests/ directory
kubectl apply -f manifests/

## Execute commands that make changes and need merging back into the source repository

### after kubectl delete completes, remove any files from the delete/ directory as they only need to be deleted once
rm -f ./delete/*

### add a placeholder file to the delete/ folder as there are sometimes git problems with empty directories
touch delete/placeholder.yml

## add and commit the changes made to the repo and push back into the pullrequest
git add .
git commit -m "post-merge processing for pr$PULLNUMBER"
git push origin master



