# ============================================================
#  10-apt.sh  —  Debian / Ubuntu Package Management
# ============================================================

alias apt='sudo apt'
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install -y'
alias remove='sudo apt remove -y'
alias purge='sudo apt purge -y'
alias autoremove='sudo apt autoremove -y'
alias search='apt search'

# ------------------------------------------------------------
# sysupdate — full system clean-up in one command
# update → upgrade → autoremove → autoclean
# ------------------------------------------------------------
sysupdate() {
    echo "➜  Updating package lists..."
    sudo apt update || return 1
    echo "➜  Upgrading packages..."
    sudo apt upgrade -y
    echo "➜  Removing unused packages..."
    sudo apt autoremove -y
    echo "➜  Cleaning apt cache..."
    sudo apt autoclean -y
    echo "✔  System fully updated."
}
