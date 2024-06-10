local wezterm = require 'wezterm'

local M = {}

function M.setup(config)
  -- Terminal Fonts
  config.font = wezterm.font 'MyFont Nerd Font Mono'
  config.font_size = 14
  config.bold_brightens_ansi_colors = 'BrightAndBold'

  -- Tab Fonts
  config.window_frame = {
    font = wezterm.font 'MyFont Nerd Font Mon',
    font_size = 14,
  }
end

return M
