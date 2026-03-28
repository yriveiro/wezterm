local M = {}

function M.setup(config)
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.webgpu_force_fallback_adapter = false
  config.animation_fps = 60
  config.max_fps = 60
  config.unicode_version = 14
  config.webgpu_preferred_adapter = nil
end

return M
