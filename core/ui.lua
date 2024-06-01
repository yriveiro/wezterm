local M = {}

function M.setup(config)
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.audible_bell = 'Disabled'

  config.color_scheme = 'nord'
  config.tab_bar_at_bottom = true
  config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }
end

return M
