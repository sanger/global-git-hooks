# Global Git Hooks

[![made-with-Markdown](https://img.shields.io/badge/Made%20with-Markdown-1f425f.svg)](http://commonmark.org)

Global client-side git hooks.
This was copied and modified from https://github.com/cloud-gov/caulking/


## Setup steps

Clone the project. From global-git-hooks root directory, run:

```make install```

This will:
- Create a new folder in your home directory, called .git-support
- Copy git hook files and gitleaks config file under this new folder
- Set your global [git config core.hooksPath](https://git-scm.com/docs/git-config#Documentation/git-config.txt-corehooksPath) to point to this new subdirectory
- Set a new git config setting hooks.gitleaks to true
- Try to install [gitleaks](https://github.com/zricethezav/gitleaks) using homebrew. If you already have it installed that's OK


## What does it do?

- Provides a way of setting up git hooks that work globally, across all your repos
- Uses that pattern to run a pre-commit check using gitleaks, which scans all your modified files (staged and unstaged) for potential credential leaks
- It calls your local, repo-specific git hooks as well, and is compatible with Lefthook (doesn't use it, but doesn't break it either)


## How does it do it?

- It changes your global git config core.hooksPath to point to a central location (~/.git-support/hooks), rather than a separate folder for each repo.
- This central location contains hook files for all the client-side git hooks
- These hooks first run any local, repo-specific hooks you have set up in the repo's .git/hooks folder
- Then, they can implement any global hook behaviour


## Changing gitleaks rules

- Edit local.toml
- Re-install using `make install`


## Adding new global hook behaviour

- Edit the relevant hook file, for example pre-commit.sh if you want it to act when running `git commit`
- Add your new behaviour
- Re-install using `make install`
- See https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks for more information about git hooks

## Troubleshooting

### My hook isn't running!

We have only currently added hook files for pre-commit and pre-push, as they are the only ones we use at this time. If you are trying to implement a different hook, you will need to add a file for it that points back to the local .git/hooks directory, like the pre-push one does.