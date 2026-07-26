# ============================================================
#  08-network.sh  —  Networking
# ============================================================

alias ping='ping -c 5'                   # ping 5 times then stop
alias wget='wget -c'                     # resume downloads by default
alias curl='curl -L'                     # follow redirects by default
alias headers='curl -I'                  # fetch HTTP headers only

# ------------------------------------------------------------
# weather — terminal weather via wttr.in
# usage: weather              → best-guess location
# usage: weather "Jammu"
# usage: weather London
# ------------------------------------------------------------
weather() {
    local loc="${1:-}"
    curl -s "https://wttr.in/${loc// /+}?F"
}

# ------------------------------------------------------------
# speedtest — quick download speed test (no extra tooling needed)
# ------------------------------------------------------------
speedtest() {
    echo "⏱  Downloading 100MB test file..."
    curl -o /dev/null http://speedtest.tele2.net/100MB.zip
}

# ------------------------------------------------------------
# cheat TOPIC — pull a cheat sheet from cheat.sh
# usage: cheat tar
# usage: cheat python/list
# ------------------------------------------------------------
cheat() {
    if [ -z "$1" ]; then
        echo "usage: cheat <command-or-topic>"
        return 1
    fi
    curl -s "https://cheat.sh/$1"
}
