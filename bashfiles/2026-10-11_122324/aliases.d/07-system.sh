# ============================================================
#  07-system.sh  —  System & Process
# ============================================================

alias top='top -o %CPU'                  # sort by CPU by default
alias ps='ps aux'
alias kill9='kill -9'
alias ports='ss -tulnp'                  # show open ports
alias myip='curl -s https://ifconfig.me && echo'     # public IP
alias localip="hostname -I | awk '{print \$1}'"       # local IP

alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias shutdown='sudo shutdown -h now'

# Pretty memory view
alias meminfo='free -h'

# ------------------------------------------------------------
# sysinfo — pleasant one-screen system summary
# ------------------------------------------------------------
sysinfo() {
    local CYAN="\033[0;36m"
    local BOLD="\033[1m"
    local RESET="\033[0m"
    printf "\n  ${BOLD}${CYAN}─── System Info ───${RESET}\n"
    printf "  Host      : %s\n" "$(hostname)"
    printf "  User      : %s\n" "$USER"
    printf "  OS        : %s\n" "$(lsb_release -ds 2>/dev/null || uname -o)"
    printf "  Kernel    : %s\n" "$(uname -r)"
    printf "  Uptime    : %s\n" "$(uptime -p 2>/dev/null | sed 's/^up //')"
    printf "  Shell     : %s\n" "$SHELL"
    if command -v free >/dev/null 2>&1; then
        printf "  Memory    : %s\n" "$(free -h | awk '/^Mem:/ {print $3" used / "$2" total"}')"
    fi
    printf "  Disk (/)  : %s\n" "$(df -h / | awk 'NR==2 {print $3" used / "$2" total ("$5" full)"}')"
    printf "  Load Avg  : %s\n\n" "$(uptime | awk -F'load average:' '{print $2}' | xargs)"
}

# ------------------------------------------------------------
# battery — show battery status (laptop only)
# ------------------------------------------------------------
battery() {
    local bat
    for bat in /sys/class/power_supply/BAT*; do
        if [ -d "$bat" ]; then
            local cap status
            cap=$(cat "$bat/capacity" 2>/dev/null)
            status=$(cat "$bat/status" 2>/dev/null)
            printf "🔋 %s%%  (%s)\n" "$cap" "$status"
            return 0
        fi
    done
    echo "✘ No battery detected."
}
