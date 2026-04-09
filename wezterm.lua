---@class Config: Wezterm
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

wezterm.log_info 'Reloading Wezterm configuration'

--- Load key tables
require('config.key_tables.copy').setup(config)
require('config.key_tables.execute').setup(config)
require('config.key_tables.pane_resize').setup(config)
require('config.key_tables.workspace').setup(config)

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
          execute_mode = ' ' .. wezterm.nerdfonts.md_console,
          workspace_mode = ' ' .. wezterm.nerdfonts.md_shield,
        },
      },
      cwd = {
        path_aliases = {
          { pattern = '~/.kube', replacement = wezterm.nerdfonts.md_kubernetes },
          {
            pattern = '~/Development/gitlab/',
            replacement = '(' .. wezterm.nerdfonts.dev_github_badge .. '):/',
          },
          {
            pattern = '~/Library/Application Support/wezterm/plugins/',
            replacement = '(wezterm-plugins):/',
          },
          { pattern = '~/Downloads', replacement = '~/' },
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
        ['opencode'] = wezterm.nerdfonts.md_robot_angry_outline,
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

wezterm.plugin
  .require('https://github.com/isseii10/workspace-picker.wezterm')
  .apply_to_config(config, {
    keybinds = {
      show_picker = { mods = 'LEADER', key = 'w' },
      create_workspace = { mods = 'LEADER', key = 'W' },
      rename_workspace = { mods = 'LEADER', key = 'e' },
    },
  })

wezterm.plugin
  .require('https://github.com/abidibo/wezterm-sessions')
  .apply_to_config(config)

-- HACK: wezterm only keeps the env when launch from Spotlight.
config.set_environment_variables = {
  PATH = '' .. os.getenv 'PATH',
}

return config
