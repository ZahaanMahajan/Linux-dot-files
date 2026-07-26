# ============================================================
#  09-history.sh  —  Command History
# ============================================================

alias h='history'
alias hg='history | grep'                # usage: hg ssh
alias hc='history -c'                    # clear session history

# Top 10 most-used commands in history
alias htop10='history | awk "{print \$2}" | sort | uniq -c | sort -rn | head -10'
