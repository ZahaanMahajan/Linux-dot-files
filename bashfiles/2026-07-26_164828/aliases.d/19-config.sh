# ============================================================
#  19-config.sh  —  Config File Shortcuts
# ============================================================

# ------------------------------------------------------------
# Edit & reload
# ------------------------------------------------------------
alias eal='vim ~/.alias.sh && source ~/.alias.sh'   # edit loader & reload
alias ead='cd ~/.aliases.d && vim .'                 # browse/edit modules
alias bashrc='vim ~/.bashrc'                         # edit .bashrc in nvim
alias aliases='vim ~/.alias.sh'                      # edit loader in nvim
alias nbashrc='nano ~/.bashrc'                       # edit .bashrc in nano
alias naliases='nano ~/.alias.sh'                    # edit loader in nano
alias cbashrc='code ~/.bashrc'                       # edit .bashrc in VS Code
alias caliases='code ~/.aliases.d'                   # open modules in VS Code

# ------------------------------------------------------------
# Reload config
# ------------------------------------------------------------
alias reload='source ~/.bashrc && echo "✔ Shell reloaded."'
alias rebash='source ~/.bashrc && echo "✔ .bashrc reloaded"'
alias realias='source ~/.alias.sh && echo "✔ All alias modules reloaded"'

# ------------------------------------------------------------
# View configs (read-only, paginated)
# ------------------------------------------------------------
alias catbash='cat ~/.bashrc | less'
alias cataliases='cat ~/.alias.sh | less'

# ------------------------------------------------------------
# lsmod — list all loaded alias modules
# ------------------------------------------------------------
lsmod() {
    local CYAN="\033[0;36m"
    local RESET="\033[0m"
    printf "\n  ${CYAN}Loaded alias modules (~/.aliases.d/):${RESET}\n"
    if [ -d "$HOME/.aliases.d" ]; then
        ls -1 "$HOME/.aliases.d"/*.sh 2>/dev/null | while IFS= read -r f; do
            printf "    • %s\n" "$(basename "$f")"
        done
        echo
    else
        echo "    (no modules directory found)"
    fi
}
