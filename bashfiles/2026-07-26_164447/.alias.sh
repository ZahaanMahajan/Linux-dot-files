#!/usr/bin/env bash
# ============================================================
#  ~/.alias.sh  —  Main Loader
# ============================================================
#  Sources every *.sh file inside ~/.aliases.d/ in alphabetical
#  order. Drop a new file into that folder and it will be picked
#  up automatically on next shell reload.
#
#  To enable, add this line to ~/.bashrc:
#      [ -f ~/.alias.sh ] && source ~/.alias.sh
# ============================================================

ALIASES_DIR="$HOME/.aliases.d"

if [ -d "$ALIASES_DIR" ]; then
    for _f in "$ALIASES_DIR"/*.sh; do
        [ -r "$_f" ] && source "$_f"
    done
    unset _f
fi
