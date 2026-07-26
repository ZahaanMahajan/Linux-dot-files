# ============================================================
#  01-navigation.sh  —  Directory Navigation  [FIXED]
# ============================================================

# Quick ups
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'                        # previous directory

# Common destinations
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias docs='cd ~/Documents'
alias dev='cd ~/Developer'
alias work='cd ~/Work'
alias conf='cd ~/.config'
alias nvimconf='cd ~/.config/nvim'
alias tmuxconf='cd ~/.config/tmux' 
alias conf='cd ~/.config/tmux' 

# ------------------------------------------------------------
# mkcd — make a directory (with parents) and cd into it
# usage: mkcd path/to/new/dir
# Uses `command mkdir` to bypass the `mkdir -pv` alias noise.
# ------------------------------------------------------------
mkcd() {
    if [ -z "$1" ]; then
        echo "usage: mkcd <directory>"
        return 1
    fi
    command mkdir -p "$1" && cd "$1"
}

# ------------------------------------------------------------
# bd — jump back to a named parent directory
# usage: bd projects   (jumps up until it finds a dir called "projects")
# ------------------------------------------------------------
bd() {
    if [ -z "$1" ]; then
        echo "usage: bd <parent-dir-name>"
        return 1
    fi
    local target="$1"
    local path="$PWD"
    while [ "$path" != "/" ]; do
        path=$(dirname "$path")
        if [ "$(basename "$path")" = "$target" ]; then
            cd "$path" && return 0
        fi
    done
    echo "✘ No parent directory named '$target' found."
    return 1
}

# Superfile 
spf() {
    os=$(uname -s)
    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    elif [[ "$os" == "Darwin" ]]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    fi

    command spf "$@"

    if [ -f "$SPF_LAST_DIR" ]; then
        source "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    fi
}
