alias daemonreload='sudo systemctl daemon-reload'
alias restartkmonad='sudo systemctl restart kmonad'

# ------------------------------------------------------------
# Toggle terminal + nvim transparency
# ------------------------------------------------------------
toggle-transparency() {
    local WEZTERM="$HOME/.config/wezterm/wezterm.lua"
    local COLORS="$HOME/.config/nvim/lua/zahaan/plugins/colors.lua"

    if grep -q "window_background_opacity = 1$" "$WEZTERM"; then
        sed -i 's/window_background_opacity = 1$/window_background_opacity = 0.9/' "$WEZTERM"
        sed -i 's/transparent_mode = false/transparent_mode = true/' "$COLORS"
        echo "Transparency ON (opacity 0.9)"
    else
        sed -i 's/window_background_opacity = 0.9/window_background_opacity = 1/' "$WEZTERM"
        sed -i 's/transparent_mode = true/transparent_mode = false/' "$COLORS"
        echo "Transparency OFF (opacity 1)"
    fi
}
