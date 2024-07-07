local M = {}

function M.setup(config)
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.audible_bell = 'Disabled'
  config.window_decorations = 'RESIZE'
  config.enable_kitty_graphics = true

  config.color_scheme = 'onenord'
  config.scrollback_lines = 10000
  config.tab_bar_at_bottom = true
  config.window_padding = {
    left = '0.5cell',
    right = '0.5cell',
    top = '0.5cell',
    bottom = '0.0cell',
  }
end

return M
