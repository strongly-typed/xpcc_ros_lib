#!/usr/bin/env bash

# Exit on first error
set -e

# Remote must be accessed by SSH as the deploy key uses SSH access only
git remote remove github || true
git remote add github ssh://git@github.com/strongly-typed/xpcc_ros_lib

export GIT_COMMITTER_NAME='Deployment Bot (from Gitlab)'
export ENV GIT_COMMITTER_EMAIL='stronglytyp3d@gmail.com'

# Gitlab checksout the source at detached HEAD
# This is for having reproducible builds.
# We need to re-attach here to have to commit add to the branch.
git checkout -B $CI_COMMIT_REF_NAME

# Add files and create commit message
git add --all
git commit --author="Deployment Bot (from Gitlab) <stronglytyp3d@gmail.com>" --all --message="Bot: Deploy generated files" || true
git show -p -1

# git push to github with deploy key
echo CI_COMMIT_REF_NAME: $CI_COMMIT_REF_NAME
git push github $CI_COMMIT_REF_NAME
