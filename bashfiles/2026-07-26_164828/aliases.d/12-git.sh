# ============================================================
#  12-git.sh  —  Git Shortcuts
# ============================================================

alias g='git'
alias gs='git status'
alias gss='git status -s'                # short / compact status
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin main'
alias gpl='git pull'
alias gplo='git pull origin'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gd='git diff'
alias gds='git diff --staged'
alias glog='git log --oneline --graph --decorate --all'
alias glast='git log -1 HEAD --stat'     # details of last commit
alias gst='git stash'
alias gstp='git stash pop'
alias gstc='git stash clear'
alias gstl='git stash list'
alias greset='git reset --hard HEAD'
alias gclean='git clean -fd'

# Undo last commit but keep the changes staged
alias gundo='git reset --soft HEAD~1'

# ------------------------------------------------------------
# gwip — quick "work in progress" checkpoint commit
# usage: gwip              → "WIP: checkpoint [HH:MM]"
# usage: gwip fixing bug   → "WIP: fixing bug [HH:MM]"
# ------------------------------------------------------------
gwip() {
    git add -A && git commit -m "WIP: ${*:-checkpoint} [$(date +%H:%M)]"
}

# ------------------------------------------------------------
# gpushnew — push the current branch and set its upstream
# ------------------------------------------------------------
gpushnew() {
    local branch
    branch=$(git branch --show-current)
    if [ -z "$branch" ]; then
        echo "✘ Not on a branch."
        return 1
    fi
    git push -u origin "$branch"
}
