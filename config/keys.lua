local wezterm = require 'wezterm'

local act = wezterm.action
local M = {}

M.cmd_mode = 'CMD'
M.leader = 'LEADER'
M.win_mode = 'ALT|SHIFT'

function M.setup(config)
  config.disable_default_key_bindings = true
  config.send_composed_key_when_left_alt_is_pressed = true
  config.send_composed_key_when_right_alt_is_pressed = true
  config.use_dead_keys = false

  config.leader = { key = 'a', mods = 'META', timeout_milliseconds = 1000 }

  config.keys = {
    -- New Tab
    { mods = M.leader, key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },
    -- Splits
    {
      mods = M.leader,
      key = '|',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      mods = M.leader,
      key = '-',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Modes
    {
      mods = M.leader,
      key = 'r',
      action = act.ActivateKeyTable {
        name = 'resize_mode',
        one_shot = false,
      },
    },
    {
      mods = M.leader,
      key = 'e',
      action = act.ActivateKeyTable {
        name = 'execute_mode',
        one_shot = false,
      },
    },

    -- Move Tabs
    { mods = M.leader, key = '>', action = act.MoveTabRelative(1) },
    { mods = M.leader, key = '<', action = act.MoveTabRelative(-1) },
    -- Activate Tabs
    { mods = M.cmd_mode, key = 'LeftArrow', action = act { ActivateTabRelative = -1 } },
    { mods = M.cmd_mode, key = 'RightArrow', action = act { ActivateTabRelative = 1 } },
    { mods = M.leader, key = '1', action = act.ActivateTab(0) },
    { mods = M.leader, key = '2', action = act.ActivateTab(1) },
    { mods = M.leader, key = '3', action = act.ActivateTab(2) },
    { mods = M.leader, key = '4', action = act.ActivateTab(3) },
    { mods = M.leader, key = '5', action = act.ActivateTab(4) },
    { mods = M.leader, key = '6', action = act.ActivateTab(5) },
    { mods = M.leader, key = '7', action = act.ActivateTab(6) },
    { mods = M.leader, key = '8', action = act.ActivateTab(7) },
    { mods = M.leader, key = '9', action = act.ActivateTab(8) },

    -- show the pane selection mode, but have it swap the active and selected panes
    {
      mods = M.leader,
      key = 's',
      action = wezterm.action.PaneSelect { mode = 'Activate' },
    },
    -- Clipboard
    { mods = M.cmd_mode, key = 'c', action = act.CopyTo 'Clipboard' },
    { mods = M.cmd_mode, key = 'v', action = act.PasteFrom 'Clipboard' },
    { mods = M.leader, key = 'Enter', action = act.ActivateCopyMode },
    { mods = M.leader, key = 'f', action = act.Search 'CurrentSelectionOrEmptyString' },
    -- Panes
    { mods = M.leader, key = 'z', action = act.TogglePaneZoomState },
    { mods = M.leader, key = 'p', action = act.ActivateCommandPalette },
    { mods = M.leader, key = 'd', action = act.ShowDebugOverlay },

    { mods = M.win_mode, key = 'LeftArrow', action = act.ActivatePaneDirection 'Prev' },
    { mods = M.win_mode, key = 'RightArrow', action = act.ActivatePaneDirection 'Next' },
    { mods = M.win_mode, key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { mods = M.win_mode, key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    -- Fonts
    { mods = M.cmd_mode, key = '+', action = act.IncreaseFontSize },
    { mods = M.cmd_mode, key = '-', action = act.DecreaseFontSize },
    -- Scroll
    {
      mods = M.cmd_mode,
      key = 'k',
      action = act.ClearScrollback 'ScrollbackAndViewport',
    },
    {
      mods = M.cmd_mode,
      key = ',',
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
  }
end

return M
