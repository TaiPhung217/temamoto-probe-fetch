#!/usr/bin/env bash
set -x
echo "MARKER: FORK-CODE-RAN (this file comes from the fork)"
echo "EVENT_NAME=$GITHUB_EVENT_NAME"
echo "GITHUB_SHA=$GITHUB_SHA"
echo "GITHUB_REF=$GITHUB_REF"
git rev-parse HEAD
git log -1 --format='commit=%H parents=%P'
git remote -v
HEAD_SHA=$(jq -r '.pull_request.head.sha' "$GITHUB_EVENT_PATH")
echo "PR_HEAD_SHA=$HEAD_SHA"
echo "--- TEST1: fetch fork head SHA directly from BASE repo URL ---"
git fetch --no-tags origin "$HEAD_SHA" && git cat-file -t "$HEAD_SHA"
echo "--- TEST2: fetch refs/pull/N/head from base ---"
PRN=$(echo "$GITHUB_REF" | sed 's|refs/pull/||; s|/merge||')
git fetch --no-tags origin "refs/pull/$PRN/head" && git rev-parse FETCH_HEAD
echo "--- TEST3: ls-remote base for pull refs ---"
git ls-remote origin "refs/pull/$PRN/*"
