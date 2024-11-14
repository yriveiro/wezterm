---@class Config: Wezterm
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

wezterm.log_info 'Reloading Wezterm configuration'

--- Load key tables
require('config.key_tables.copy').setup(config)
require('config.key_tables.pane_resize').setup(config)

require('config.keys').setup(config)
require('config.fonts').setup(config)
require('config.gpu').setup(config)
require('config.ui').setup(config)
-- require('config.tabs').setup(config)
require 'events.triggers'

wezterm.plugin
  .require('https://github.com/yriveiro/wezterm-status')
  .apply_to_config(config, {
    cells = {
      date = {
        format = '%H:%M',
      },
      mode = {
        modes = {
          resize_mode = ' ' .. wezterm.nerdfonts.md_resize,
        },
      },
    },
  })

wezterm.plugin
  .require('https://github.com/yriveiro/wezterm-tabs')
  .apply_to_config(config, {
    ui = {
      icons = {
        ['obsidian'] = wezterm.nerdfonts.cod_checklist,
        ['k9s'] = wezterm.nerdfonts.fa_ship,
      },
    },
  })

return config
