local wezterm = require 'wezterm'
local config = wezterm.config_builder()

wezterm.log_info 'reloading'

require('core.tabs').setup(config)
require('core.fonts').setup(config)
require('core.keys').setup(config)
require('core.ui').setup(config)

return config
