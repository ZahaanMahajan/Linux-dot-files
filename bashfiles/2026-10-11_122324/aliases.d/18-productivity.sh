# ============================================================
#  18-productivity.sh  —  Productivity Shortcuts  [FIXED]
# ============================================================

alias cls='clear'
alias q='exit'
alias path='echo -e ${PATH//:/\\n}'      # pretty-print PATH entries
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'                     # current week number
alias epoch='date +%s'                    # current unix timestamp
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# ------------------------------------------------------------
# extract — extract any archive, auto-detecting the format
# ------------------------------------------------------------
extract() {
    if [ -z "$1" ]; then
        echo "usage: extract <archive>"
        return 1
    fi
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"   ;;
            *.tar.gz)   tar xzf "$1"   ;;
            *.tar.xz)   tar xJf "$1"   ;;
            *.bz2)      bunzip2 "$1"   ;;
            *.gz)       gunzip  "$1"   ;;
            *.rar)      unrar x "$1"   ;;
            *.zip)      unzip   "$1"   ;;
            *.7z)       7z x    "$1"   ;;
            *.tar)      tar xf  "$1"   ;;
            *)          echo "'$1' cannot be extracted automatically." ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}

# ------------------------------------------------------------
# serve — quick HTTP server in the current directory
# usage: serve           → port 8000
# usage: serve 3000      → port 3000
# ------------------------------------------------------------
serve() { python3 -m http.server "${1:-8000}"; }

# ------------------------------------------------------------
# bak — create a dated backup copy of a file
# Uses `command cp` to bypass the `cp -iv` alias.
# ------------------------------------------------------------
bak() {
    if [ -z "$1" ]; then
        echo "usage: bak <file>"
        return 1
    fi
    if [ ! -e "$1" ]; then
        echo "✘ '$1' does not exist."
        return 1
    fi
    local dest="${1}.$(date +%Y%m%d_%H%M%S).bak"
    command cp "$1" "$dest" && echo "✔ Backup created: $dest"
}

# ------------------------------------------------------------
# hr — print a horizontal rule
# usage: hr             → 80 dashes
# usage: hr 40 '='      → 40 equals signs
# ------------------------------------------------------------
hr() {
    local len="${1:-80}"
    local char="${2:--}"
    local line=""
    for ((i=0; i<len; i++)); do line+="$char"; done
    echo "$line"
}

# ------------------------------------------------------------
# genpass — generate a random password
# usage: genpass        → 20 chars
# usage: genpass 32     → 32 chars
# ------------------------------------------------------------
genpass() {
    local len="${1:-20}"
    LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()_+-=' < /dev/urandom | head -c "$len"
    echo
}

# ------------------------------------------------------------
# qr — generate a QR code for any text in the terminal
# usage: qr "https://example.com"
# ------------------------------------------------------------
qr() {
    if [ -z "$1" ]; then
        echo "usage: qr <text-or-url>"
        return 1
    fi
    curl -s "https://qrenco.de/$1"
}
