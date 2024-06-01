local w = require 'wezterm'
local config = w.config_builder()

w.log_info 'reloading'

require('core.fonts').setup(config)
require('core.ui').setup(config)

return config
