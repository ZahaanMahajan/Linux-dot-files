# ============================================================
#  14-tmux.sh  —  Tmux Shortcuts
# ============================================================

alias t='tmux'
alias ta='tmux attach'                    # attach to last session
alias tat='tmux attach -t'                # usage: tat mysession
alias tn='tmux new-session'               # new unnamed session
alias tns='tmux new-session -s'           # usage: tns mysession
alias tls='tmux list-sessions'            # list all sessions
alias tlw='tmux list-windows'             # list windows in current session
alias tlp='tmux list-panes'               # list panes in current window
alias tk='tmux kill-session'              # kill current session
alias tkt='tmux kill-session -t'          # usage: tkt mysession
alias tka='tmux kill-server'              # kill ALL sessions
alias ts='tmux switch -t'                 # usage: ts mysession
alias tr='tmux rename-session -t'         # usage: tr old new
alias td='tmux detach'                    # detach from session

# Windows
alias tnw='tmux new-window'               # open a new window
alias trw='tmux rename-window'            # rename current window
alias tnx='tmux next-window'              # next window
alias tpw='tmux previous-window'          # previous window

# Panes
alias tsp='tmux split-window -h'          # split side-by-side (vertical bar)
alias tsh='tmux split-window -v'          # split top/bottom (horizontal bar)
alias tzp='tmux resize-pane -Z'           # zoom / unzoom current pane

# Config
alias tconf='vim ~/.config/tmux/tmux.conf'
alias treload='tmux source-file ~/.config/tmux/tmux.conf && echo "✔ tmux config reloaded"'

# ------------------------------------------------------------
# tm — smart attach: attach if session exists, else create it
# usage: tm          → session named "main"
# usage: tm work     → session named "work"
# ------------------------------------------------------------
tm() {
    local name="${1:-main}"
    if tmux has-session -t "$name" 2>/dev/null; then
        tmux attach -t "$name"
    else
        tmux new-session -s "$name"
    fi
}
