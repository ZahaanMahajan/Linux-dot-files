# ============================================================
#  05-search.sh  —  Search & Find
# ============================================================

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Case-insensitive, recursive grep
alias grepi='grep -ri'

# Find files/dirs by name in current tree
alias ff='find . -type f -name'          # usage: ff "*.log"
alias fd='find . -type d -name'          # usage: fd "node_modules"

# Filter running processes
alias psg='ps aux | grep -v grep | grep'

# ------------------------------------------------------------
# qfind PATTERN — quick file finder with pretty output
# usage: qfind config
# ------------------------------------------------------------
qfind() {
    if [ -z "$1" ]; then
        echo "usage: qfind <pattern>"
        return 1
    fi
    find . -iname "*$1*" 2>/dev/null | head -n 50
}
