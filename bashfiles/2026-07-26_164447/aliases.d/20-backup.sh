# ============================================================
#  20-backup.sh  —  Safe Versioned Bash Config Backups  [FIXED]
# ============================================================
#  Every call to `backupbash` creates a new timestamped snapshot
#  at ~/.config/bashfiles/<YYYY-MM-DD_HHMMSS>/ so previous
#  snapshots are NEVER overwritten.
#
#  FIX: uses `command cp/mkdir/ln/rmdir` inside functions to
#  bypass the `cp -iv` / `mv -iv` aliases that caused the old
#  backupbash to prompt for overwrites and hang indefinitely.
#
#  Commands:
#    backupbash            create a new snapshot
#    lsbackups             list all snapshots
#    restorebash [name]    restore from a snapshot (default: latest)
#    diffbash [name]       diff live configs vs a snapshot
#    cdbash                cd into the backup root
# ============================================================

BASH_BACKUP_DIR="$HOME/.config/bashfiles/"

# ------------------------------------------------------------
# backupbash — create a new timestamped snapshot
# ------------------------------------------------------------
backupbash() {
    local stamp snap copied=0
    stamp=$(date +%Y-%m-%d_%H%M%S)
    snap="$BASH_BACKUP_DIR/$stamp"

    command mkdir -p "$snap" || { echo "✘ Cannot create $snap"; return 1; }

    if [ -f "$HOME/.bashrc" ]; then
        command cp "$HOME/.bashrc" "$snap/.bashrc" && copied=$((copied+1))
    else
        echo "⚠  ~/.bashrc not found — skipping."
    fi

    if [ -f "$HOME/.alias.sh" ]; then
        command cp "$HOME/.alias.sh" "$snap/.alias.sh" && copied=$((copied+1))
    else
        echo "⚠  ~/.alias.sh not found — skipping."
    fi

    if [ -d "$HOME/.aliases.d" ]; then
        command mkdir -p "$snap/aliases.d"
        command cp -r "$HOME/.aliases.d/." "$snap/aliases.d/" && copied=$((copied+1))
    else
        echo "⚠  ~/.aliases.d not found — skipping."
    fi

    if [ "$copied" -eq 0 ]; then
        command rmdir "$snap" 2>/dev/null
        echo "✘ Nothing to back up."
        return 1
    fi

    # 'latest' symlink always points at the most-recent snapshot
    command ln -sfn "$snap" "$BASH_BACKUP_DIR/latest"

    echo "✔ Snapshot: $snap  ($copied item(s) saved)"
}

# ------------------------------------------------------------
# lsbackups — list all snapshots
# ------------------------------------------------------------
lsbackups() {
    if [ ! -d "$BASH_BACKUP_DIR" ]; then
        echo "No backup directory yet. Run 'backupbash' to create one."
        return 0
    fi

    local CYAN="\033[0;36m"
    local RESET="\033[0m"
    printf "\n  ${CYAN}Snapshots in %s${RESET}\n" "$BASH_BACKUP_DIR"
    local count=0
    local d name
    for d in "$BASH_BACKUP_DIR"/*/; do
        [ -d "$d" ] || continue
        name=$(basename "$d")
        [ "$name" = "latest" ] && continue
        printf "    • %s\n" "$name"
        count=$((count+1))
    done
    if [ "$count" -eq 0 ]; then
        echo "    (none yet)"
    fi
    echo
}

# ------------------------------------------------------------
# restorebash [name] — restore from a snapshot
#   name defaults to "latest"
#   Takes a safety snapshot of current state before overwriting.
# ------------------------------------------------------------
restorebash() {
    local name="${1:-latest}"
    local snap="$BASH_BACKUP_DIR/$name"

    if [ ! -d "$snap" ]; then
        echo "✘ Snapshot not found: $snap"
        lsbackups
        return 1
    fi

    local ans
    read -r -p "Restore from '$name'? Current configs will be overwritten. [y/N] " ans
    case "$ans" in
        [yY]|[yY][eE][sS]) ;;
        *) echo "Cancelled."; return 0 ;;
    esac

    echo "➜  Taking a safety snapshot of current state first..."
    backupbash

    [ -f "$snap/.bashrc" ]   && command cp "$snap/.bashrc"   "$HOME/.bashrc"
    [ -f "$snap/.alias.sh" ] && command cp "$snap/.alias.sh" "$HOME/.alias.sh"
    if [ -d "$snap/aliases.d" ]; then
        command mkdir -p "$HOME/.aliases.d"
        command cp -r "$snap/aliases.d/." "$HOME/.aliases.d/"
    fi

    echo "✔ Restored from $name. Run 'source ~/.bashrc' to apply."
}

# ------------------------------------------------------------
# diffbash [name] — compare live configs against a snapshot
# ------------------------------------------------------------
diffbash() {
    local name="${1:-latest}"
    local snap="$BASH_BACKUP_DIR/$name"

    if [ ! -d "$snap" ]; then
        echo "✘ Snapshot not found: $snap"
        lsbackups
        return 1
    fi

    echo "=== diff: .bashrc ==="
    if [ -f "$snap/.bashrc" ] && [ -f "$HOME/.bashrc" ]; then
        diff "$HOME/.bashrc" "$snap/.bashrc" || true
    else
        echo "(one side missing)"
    fi
    echo ""
    echo "=== diff: .alias.sh ==="
    if [ -f "$snap/.alias.sh" ] && [ -f "$HOME/.alias.sh" ]; then
        diff "$HOME/.alias.sh" "$snap/.alias.sh" || true
    else
        echo "(one side missing)"
    fi
    echo ""
    echo "=== diff: .aliases.d/ ==="
    if [ -d "$snap/aliases.d" ] && [ -d "$HOME/.aliases.d" ]; then
        diff -r "$HOME/.aliases.d" "$snap/aliases.d" || true
    else
        echo "(one side missing)"
    fi
}

# ------------------------------------------------------------
# cdbash — jump to the backup root
# ------------------------------------------------------------
alias cdbash='cd "$BASH_BACKUP_DIR"'
