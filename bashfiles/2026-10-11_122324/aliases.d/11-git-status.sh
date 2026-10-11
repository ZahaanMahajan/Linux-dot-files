# ============================================================
#  11-git-status.sh  —  Git File Status & Listing
# ============================================================
#  gll   — all tracked files                        [green]
#  gllu  — untracked files not in .gitignore        [red]
#  glld  — untracked folders not in .gitignore      [red]
#  glla  — everything: tracked + modified + untracked
#  gshow — full categorized status view
# ============================================================

# ------------------------------------------------------------
# gll — list all clean tracked files [green]
# ------------------------------------------------------------
gll() {
    git ls-files | while IFS= read -r f; do
        printf "\033[0;32m[+] %s\033[0m\n" "$f"
    done
}

# ------------------------------------------------------------
# gllu — list untracked files NOT in .gitignore [red]
# ------------------------------------------------------------
gllu() {
    git ls-files --others --exclude-standard | while IFS= read -r f; do
        printf "\033[0;31m[?] %s\033[0m\n" "$f"
    done
}

# ------------------------------------------------------------
# glld — list untracked non-ignored FOLDERS only [red]
# ------------------------------------------------------------
glld() {
    git ls-files --others --exclude-standard --directory | while IFS= read -r d; do
        printf "\033[0;31m[?] %s\033[0m\n" "$d"
    done
}

# ------------------------------------------------------------
# glla — list ALL visible files
#   clean     = green   [+]
#   modified  = yellow  [M]
#   untracked = red     [?]
# ------------------------------------------------------------
glla() {
    local GREEN="\033[0;32m"
    local YELLOW="\033[0;33m"
    local RED="\033[0;31m"
    local RESET="\033[0m"

    declare -A modified
    while IFS= read -r line; do
        local xy="${line:0:2}"
        local file="${line:3}"
        modified["$file"]="$xy"
    done < <(git status --porcelain 2>/dev/null)

    # Tracked files — colored by status
    git ls-files | while IFS= read -r f; do
        local xy="${modified[$f]}"
        if [[ -n "$xy" ]]; then
            printf "${YELLOW}[M] %s${RESET}\n" "$f"
        else
            printf "${GREEN}[+] %s${RESET}\n" "$f"
        fi
    done

    # Untracked non-ignored files
    git ls-files --others --exclude-standard | while IFS= read -r f; do
        printf "${RED}[?] %s${RESET}\n" "$f"
    done
}

# ------------------------------------------------------------
# gshow — full categorized status view
# ------------------------------------------------------------
gshow() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo "[ERROR] Not inside a git repository."
        return 1
    fi

    local GREEN="\033[0;32m"
    local RED="\033[0;31m"
    local YELLOW="\033[0;33m"
    local CYAN="\033[0;36m"
    local BOLD="\033[1m"
    local RESET="\033[0m"

    local root branch
    root=$(git rev-parse --show-toplevel)
    branch=$(git branch --show-current 2>/dev/null || echo "no branch")

    echo ""
    printf "  ${BOLD}${CYAN}[%s]${RESET}  ${BOLD}branch: %s${RESET}\n" "$(basename "$root")" "$branch"
    printf "  %s\n" "$(printf '%0.s-' {1..48})"
    echo ""

    # Parse porcelain for staged / modified / deleted
    local staged_files=""
    local modified_files=""
    local deleted_files=""

    while IFS= read -r line; do
        local xy="${line:0:2}"
        local file="${line:3}"
        case "$xy" in
            "A "|"M "|"R ") staged_files+="$file"$'\n' ;;
            " M"|"MM")      modified_files+="$file"$'\n' ;;
            " D"|"D ")      deleted_files+="$file"$'\n' ;;
        esac
    done < <(git status --porcelain 2>/dev/null)

    # Clean tracked files
    local all_modified
    all_modified=$(git status --porcelain | awk '{print $2}')

    printf "  ${BOLD}${GREEN}[+] Tracked / Clean${RESET}\n"
    git ls-files | while IFS= read -r f; do
        if ! echo "$all_modified" | grep -qx "$f"; then
            printf "      ${GREEN}%s${RESET}\n" "$f"
        fi
    done
    echo ""

    # Staged
    printf "  ${BOLD}${CYAN}[S] Staged${RESET}\n"
    if [ -n "$staged_files" ]; then
        echo "$staged_files" | grep -v '^$' | while IFS= read -r f; do
            printf "      ${CYAN}%s${RESET}\n" "$f"
        done
    else
        printf "      ${CYAN}(none)${RESET}\n"
    fi
    echo ""

    # Modified
    printf "  ${BOLD}${YELLOW}[M] Modified (not staged)${RESET}\n"
    if [ -n "$modified_files" ]; then
        echo "$modified_files" | grep -v '^$' | while IFS= read -r f; do
            printf "      ${YELLOW}%s${RESET}\n" "$f"
        done
    else
        printf "      ${YELLOW}(none)${RESET}\n"
    fi
    echo ""

    # Deleted
    printf "  ${BOLD}${RED}[D] Deleted${RESET}\n"
    if [ -n "$deleted_files" ]; then
        echo "$deleted_files" | grep -v '^$' | while IFS= read -r f; do
            printf "      ${RED}%s${RESET}\n" "$f"
        done
    else
        printf "      ${RED}(none)${RESET}\n"
    fi
    echo ""

    # Untracked
    printf "  ${BOLD}${RED}[?] Untracked (not in .gitignore)${RESET}\n"
    local untracked
    untracked=$(git ls-files --others --exclude-standard)
    if [ -n "$untracked" ]; then
        echo "$untracked" | while IFS= read -r f; do
            printf "      ${RED}%s${RESET}\n" "$f"
        done
    else
        printf "      ${RED}(none)${RESET}\n"
    fi
    echo ""
}
