#!/bin/bash
previous_commit_hash=$(git log --format="%H" -n 2 | tail -n 1)
echo "Rolling back to commit hash: $previous_commit_hash"
git checkout master
git reset --hard $previous_commit_hash
