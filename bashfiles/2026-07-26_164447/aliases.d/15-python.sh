# ============================================================
#  15-python.sh  —  Python / pip / venv
# ============================================================

alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv venv'
alias activate='source venv/bin/activate'
alias pipi='pip3 install'
alias pipr='pip3 install -r requirements.txt'
alias pipfreeze='pip3 freeze > requirements.txt && echo "✔ requirements.txt updated"'

# ------------------------------------------------------------
# mkvenv — create a venv and activate it in one step
# ------------------------------------------------------------
mkvenv() {
    local name="${1:-venv}"
    python3 -m venv "$name" && source "$name/bin/activate"
    echo "✔ Virtual env '$name' created and activated."
}
