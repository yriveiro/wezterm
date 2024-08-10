local M = {}

function M.setup(config)
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.webgpu_force_fallback_adapter = false
  config.animation_fps = 60
end

return M
