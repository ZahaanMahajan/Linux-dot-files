# ============================================================
#  06-disk.sh  —  Disk Usage
# ============================================================

alias df='df -h'                         # human-readable disk free
alias du='du -h'                         # human-readable dir sizes
alias du1='du -h --max-depth=1'          # top-level sizes only
alias ducks='du -chs * 2>/dev/null | sort -rh | head -20'   # top 20 largest items

# ------------------------------------------------------------
# dus — sorted disk usage summary of current directory
# ------------------------------------------------------------
dus() {
    echo "Disk usage summary for: $PWD"
    echo "--------------------------------------------"
    du -sh -- */ 2>/dev/null | sort -rh | head -n 15
}
