local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.initial_cols = 160
config.initial_rows = 40

config.window_padding = {
	left = 8,
	right = 8,
	top = 58,
	bottom = 2,
}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 13
config.line_height = 1.3
config.cell_width = 1.0
config.color_scheme = "Sonokai (Gogh)"

config.window_decorations = "INTEGRATED_BUTTONS"

return config
