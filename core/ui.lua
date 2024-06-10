local M = {}

function M.setup(config)
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.audible_bell = 'Disabled'

  config.color_scheme = 'onenord'
  config.scrollback_lines = 10000
  config.tab_bar_at_bottom = true
  config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
end

return M
