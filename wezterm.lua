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
require 'events.triggers'

wezterm.plugin
  .require('https://github.com/yriveiro/wezterm-status')
  .apply_to_config(config, {
    cells = {
      date = {
        format = '%H:%M',
      },
      workspace = { enabled = true },
      k8s_context = { enabled = true },
      mode = {
        modes = {
          resize_mode = ' ' .. wezterm.nerdfonts.md_resize,
        },
      },
      cwd = {
        path_aliases = {
          { pattern = '~/.kube', replacement = wezterm.nerdfonts.md_kubernetes },
          {
            pattern = '~/Development/github/',
            replacement = '(' .. wezterm.nerdfonts.dev_github_alt .. '):/',
          },
          {
            pattern = '~/Development/aqom/',
            replacement = '(' .. wezterm.nerdfonts.dev_github_alt .. '):aqom:/',
          },
          {
            pattern = '~/Library/Application Support/wezterm/plugins/',
            replacement = '(wezterm-plugins):/',
          },
          {
            pattern = '~/Downloads',
            replacement = '~/' .. wezterm.nerdfonts.md_download_outline,
          },
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
        ['neutron'] = wezterm.nerdfonts.md_phone_plus,
        ['ruby'] = wezterm.nerdfonts.seti_ruby,
      },
      tab = {
        zoom_indicator = {
          -- Enable zoom level indicator
          enabled = true,
          -- Display type of the zoom indicator
          type = 'number',
        },
      },
    },
  })

-- HACK: wezterm only keeps the env when launch from Spotlight.
config.set_environment_variables = {
  PATH = '' .. os.getenv 'PATH',
}

return config
