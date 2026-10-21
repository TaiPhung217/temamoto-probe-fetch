#!/usr/bin/env bash
set -x
echo "MARKER: BASE-CODE-RAN"
echo "EVENT_NAME=$GITHUB_EVENT_NAME"
echo "GITHUB_SHA=$GITHUB_SHA"
echo "GITHUB_REF=$GITHUB_REF"
git rev-parse HEAD
git log -1 --format='commit=%H parents=%P'
git remote -v
