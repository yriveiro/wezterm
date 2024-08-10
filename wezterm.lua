---@class Config: Wezterm
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

wezterm.log_info 'Reloading Wezterm configuration'

require('config.keys').setup(config)
require('config.fonts').setup(config)
require('config.gpu').setup(config)
require('config.ui').setup(config)
-- require('config.tabs').setup(config)

wezterm.plugin
  .require('https://github.com/yriveiro/wezterm-status')
  .apply_to_config(config, { cells = { date = {
    format = '%H:%M',
  } } })

wezterm.plugin.require('https://github.com/yriveiro/wezterm-tabs').apply_to_config(config)

return config
