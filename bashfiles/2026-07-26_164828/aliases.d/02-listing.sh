# ============================================================
#  02-listing.sh  —  Directory Listing (ls)
# ============================================================

# LSD Commands
alias ls='lsd'
alias l='ls -CF'                         # compact, classifies entries
alias la='lsd -a'                        # all files (no . and ..)
alias lla='lsd -la'                      # long list, human sizes
alias lt='lsd --tree'                    # sort by newest first

alias lh='ls -lh'                        # long list, human sizes
alias lS='ls -lSh'                       # sort by largest first
alias ldir='ls -d */'                    # list directories only

# Show the 10 most recently modified items
alias recent='ls -lth | head -n 11'

# ------------------------------------------------------------
# tree2 — tree view with sensible depth limit
# usage: tree2        → depth 2
# usage: tree2 3      → depth 3
# ------------------------------------------------------------
tree2() {
    if command -v tree >/dev/null 2>&1; then
        tree -L "${1:-2}" --dirsfirst -C
    else
        echo "✘ 'tree' is not installed. Try: sudo apt install tree"
    fi
}
