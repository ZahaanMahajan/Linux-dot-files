-- ╔══════════════════════════════════════════════════╗
-- ║       WezTerm · Solarized Osaka Dark             ║
-- ╚══════════════════════════════════════════════════╝
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ── Solarized Osaka Dark palette ───────────────────
-- Base tones
local base03 = "#030f14" -- darkest background (Osaka deepens solarized's base03)
local base02 = "#073642" -- background highlights
local base01 = "#586e75" -- comments / secondary content
local base00 = "#657b83" -- body text (light-bg use)
local base0 = "#839496" -- primary body text
local base1 = "#93a1a1" -- emphasized content
local base2 = "#eee8d5" -- background highlights (light)
local base3 = "#fdf6e3" -- lightest background
-- Accent colors
local yellow = "#b58900"
local orange = "#cb4b16"
local red = "#dc322f"
local magenta = "#d33682"
local violet = "#6c71c4"
local blue = "#268bd2"
local cyan = "#2aa198"
local green = "#859900"

-- ── Theme ──────────────────────────────────────────
-- Use the closest built-in scheme as a base, then override
-- via config.colors for precise Osaka palette control
config.color_scheme = "Solarized Dark (Gogh)"

-- ── Font ───────────────────────────────────────────
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
	{ family = "JetBrains Mono", weight = "Regular" },
	"Noto Color Emoji",
})
config.font_size = 16.0
config.line_height = 1.0

-- ── Window ─────────────────────────────────────────
config.window_background_opacity = 0.95
config.window_padding = { left = 12, right = 12, top = 12, bottom = 4 }
config.window_decorations = "RESIZE"
config.initial_cols = 140
config.initial_rows = 38

-- ── Tab bar ────────────────────────────────────────
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- ── Colors — full Solarized Osaka Dark override ────
config.colors = {
	-- Terminal ANSI palette
	foreground = base0,
	background = base03,
	cursor_bg = cyan,
	cursor_fg = base03,
	cursor_border = cyan,

	selection_bg = base02,
	selection_fg = base1,

	ansi = {
		base02, -- black   (0)
		red, -- red     (1)
		green, -- green   (2)
		yellow, -- yellow  (3)
		blue, -- blue    (4)
		magenta, -- magenta (5)
		cyan, -- cyan    (6)
		base2, -- white   (7)
	},
	brights = {
		base03, -- bright black   (8)
		orange, -- bright red     (9)
		base01, -- bright green   (10)
		base00, -- bright yellow  (11)
		base0, -- bright blue    (12)
		violet, -- bright magenta (13)
		base1, -- bright cyan    (14)
		base3, -- bright white   (15)
	},

	tab_bar = {
		background = base03, -- Osaka's deepened base03
		active_tab = {
			bg_color = base02, -- bg highlight
			fg_color = cyan, -- teal accent — Osaka signature
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = base03,
			fg_color = base01, -- muted
		},
		inactive_tab_hover = {
			bg_color = base02,
			fg_color = base1,
		},
		new_tab = {
			bg_color = base03,
			fg_color = base01,
		},
	},
}

-- ── Cursor ─────────────────────────────────────────
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- ── Scroll ─────────────────────────────────────────
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- ── Keys ───────────────────────────────────────────
config.keys = {
	{ key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
}

-- ── Misc ───────────────────────────────────────────
config.audible_bell = "Disabled"
config.check_for_updates = false

return config
