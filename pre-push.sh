#!/bin/sh

# This calls the pre-push git hook local to the repo
git_dir=$(git rev-parse --git-dir)
if [ -f "$git_dir/hooks/pre-push" ]; then
    set -e
    "$git_dir/hooks/pre-push" "$@"
    set +e
fi
