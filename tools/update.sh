#!/usr/bin/env zsh

if [ -z "$ZSH_VERSION" ]; then
  exec zsh "$0"
fi

cd "$ZSH_CUSTOM"

# Use colors, but only if connected to a terminal
# and that terminal supports them.

local RED GREEN YELLOW BLUE BOLD DIM RESET

if [ -t 1 ]; then

  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  BOLD=$(printf '\033[1m')
  DIM=$(printf '\033[2m')
  RESET=$(printf '\033[m')
fi

# Set git-config values known to fix git errors
# Line endings (#4069)
git config core.eol lf
git config core.autocrlf false
# zeroPaddedFilemode fsck errors (#4963)
git config fsck.zeroPaddedFilemode ignore
git config fetch.fsck.zeroPaddedFilemode ignore
git config receive.fsck.zeroPaddedFilemode ignore
# autostash on rebase (#7172)
resetAutoStash=$(git config --bool rebase.autoStash 2>/dev/null)
git config rebase.autoStash true

local ret=0

# Update Oh My Zsh
printf "${BLUE}%s${RESET}\n" "Updating Custom Oh My Zsh config"
last_commit=$(git rev-parse HEAD)
if git pull --rebase --stat origin master; then
  # Check if it was really updated or not
  if [[ "$(git rev-parse HEAD)" = "$last_commit" ]]; then
    printf "${YELLOW}%s${RESET}\n" "Custom Oh My Zsh is already at the latest version."
    ret=80 # non-zero exit code to indicate no changes pulled
  else
    printf "${GREEN}%s${RESET}\n" "Custom Oh My Zsh config has been updated!"
    printf "${BLUE}${BOLD}%s${RESET}\n" "Changes:"

    local change
    git --no-pager log --format=tformat:%s ${last_commit}..HEAD || while read change; do
      printf "${BLUE}- ${DIM}%s${RESET}" "$change"
    done
  fi
else
  ret=$?
  printf "${RED}%s${RESET}\n" 'There was an error updating. Try again later?'
fi

# Unset git-config values set just for the upgrade
case "$resetAutoStash" in
  "") git config --unset rebase.autoStash ;;
  *) git config rebase.autoStash "$resetAutoStash" ;;
esac

# Exit with `1` if the update failed
exit $ret