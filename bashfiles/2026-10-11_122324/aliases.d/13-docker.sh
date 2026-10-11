# ============================================================
#  13-docker.sh  —  Docker Shortcuts
# ============================================================

alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop $(docker ps -q)'    # stop all running containers
alias dclean='docker system prune -af'        # remove all unused objects
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'

# ------------------------------------------------------------
# dexec NAME — exec into a running container (bash, fallback to sh)
# ------------------------------------------------------------
dexec() {
    if [ -z "$1" ]; then
        echo "usage: dexec <container-name-or-id>"
        return 1
    fi
    docker exec -it "$1" /bin/bash 2>/dev/null || docker exec -it "$1" /bin/sh
}

# ------------------------------------------------------------
# dlogs NAME — follow logs of a container
# ------------------------------------------------------------
dlogs() {
    if [ -z "$1" ]; then
        echo "usage: dlogs <container-name-or-id>"
        return 1
    fi
    docker logs -f "$1"
}
