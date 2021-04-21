#!/bin/sh

# This calls the pre-commit git hook local to the repo, before running our global one
git_dir=$(git rev-parse --git-dir)
if [ -f "$git_dir/hooks/pre-commit" ]; then
    set -e
    "$git_dir/hooks/pre-commit" "$@"
    set +e
fi


cmd="${TALISMAN_HOME}/talisman_hook_script pre-commit"
$cmd
