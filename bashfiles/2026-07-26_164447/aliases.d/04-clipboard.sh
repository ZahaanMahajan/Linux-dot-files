# ============================================================
#  04-clipboard.sh  —  Clipboard & File Content Copying
# ============================================================
#  Requires xclip:   sudo apt install xclip
# ============================================================

alias copy='xclip -selection clipboard <'           # usage: copy file.txt
alias paste='xclip -selection clipboard -o'         # paste clipboard to stdout
alias showclip='xclip -selection clipboard -o'      # show clipboard contents
alias clearclip='echo -n "" | xclip -selection clipboard && echo "✔ Clipboard cleared"'

# ------------------------------------------------------------
# cpy FILE — copy a file's contents to clipboard
# ------------------------------------------------------------
cpy() {
    if [ -f "$1" ]; then
        xclip -selection clipboard < "$1"
        echo "✔ Copied contents of '$1' to clipboard ($(wc -l < "$1") lines)"
    else
        echo "✘ '$1' is not a file."
    fi
}

# ------------------------------------------------------------
# cppath FILE — copy absolute path of a file to clipboard
# ------------------------------------------------------------
cppath() {
    if [ -e "$1" ]; then
        realpath "$1" | tr -d '\n' | xclip -selection clipboard
        echo "✔ Path copied: $(realpath "$1")"
    else
        echo "✘ '$1' does not exist."
    fi
}

# ------------------------------------------------------------
# ccopy CMD...  — run a command and copy its stdout to clipboard
# usage: ccopy ls -la
# ------------------------------------------------------------
ccopy() { "$@" | xclip -selection clipboard && echo "✔ Output copied to clipboard"; }

# ------------------------------------------------------------
# catcp FILE — print a file AND copy it at the same time
# ------------------------------------------------------------
catcp() {
    if [ -f "$1" ]; then
        cat "$1" | tee /dev/tty | xclip -selection clipboard
        echo "✔ Contents also copied to clipboard."
    else
        echo "✘ '$1' is not a file."
    fi
}

# ------------------------------------------------------------
# diffcp A B — diff two files and copy the result
# ------------------------------------------------------------
diffcp() { diff "$1" "$2" | xclip -selection clipboard && echo "✔ Diff copied to clipboard"; }
