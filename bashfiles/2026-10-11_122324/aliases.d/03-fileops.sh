# ============================================================
#  03-fileops.sh  —  File Operations  [FIXED]
# ============================================================
#  Aliases here add -i to cp/mv/rm for SAFETY at the prompt.
#  But functions defined in other modules must use `command cp`,
#  `command mv`, etc. to bypass these aliases and avoid hanging
#  on interactive prompts.
# ============================================================

alias cp='cp -iv'                        # confirm + verbose
alias mv='mv -iv'                        # confirm + verbose
alias rm='rm -Iv'                        # confirm before mass deletes
alias mkdir='mkdir -pv'                  # make parent dirs, verbose
alias ln='ln -v'                         # verbose symlinks
alias mkd='mkdir -pv'                    # quick alias

# Safe copy with progress bar (requires rsync)
alias cpv='rsync -ah --info=progress2'

# ------------------------------------------------------------
# trash — safer alternative to rm; moves files to ~/.local/share/Trash
# usage: trash FILE [FILE...]
# ------------------------------------------------------------
trash() {
    local trash_dir="$HOME/.local/share/Trash/files"
    command mkdir -p "$trash_dir"
    if [ $# -eq 0 ]; then
        echo "usage: trash <file> [file...]"
        return 1
    fi
    for f in "$@"; do
        if [ -e "$f" ]; then
            # command mv bypasses the mv -iv alias so this never prompts
            command mv "$f" "$trash_dir/$(basename "$f").$(date +%s)" \
                && echo "✔ trashed: $f"
        else
            echo "✘ '$f' does not exist."
        fi
    done
}

# ------------------------------------------------------------
# emptytrash — permanently empty the trash directory
# ------------------------------------------------------------
emptytrash() {
    local trash_dir="$HOME/.local/share/Trash/files"
    if [ -d "$trash_dir" ] && [ -n "$(ls -A "$trash_dir" 2>/dev/null)" ]; then
        local ans
        read -r -p "Permanently delete everything in the trash? [y/N] " ans
        case "$ans" in
            [yY]|[yY][eE][sS])
                command rm -rf "$trash_dir"/* && echo "✔ Trash emptied."
                ;;
            *)
                echo "Cancelled."
                ;;
        esac
    else
        echo "Trash is already empty."
    fi
}
