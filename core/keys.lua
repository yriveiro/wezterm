local wezterm = require 'wezterm'

local act = wezterm.action
local M = {}

M.cmd_mode = 'CMD'
M.leader_mode = 'LEADER'
M.win_mode = 'ALT|SHIFT'

function M.setup(config)
  config.disable_default_key_bindings = true
  config.send_composed_key_when_left_alt_is_pressed = true

  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 500 }

  config.keys = {
    -- New Tab
    { mods = M.leader_mode, key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },
    -- Splits
    { mods = M.leader_mode, key = '|', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { mods = M.leader_mode, key = '-', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { mods = M.leader_mode, key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 5 } },
    { mods = M.leader_mode, key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 5 } },
    -- Move Tabs
    { mods = M.leader_mode, key = '>', action = act.MoveTabRelative(1) },
    { mods = M.leader_mode, key = '<', action = act.MoveTabRelative(-1) },
    -- Activate Tabs
    { mods = M.cmd_mode, key = 'LeftArrow', action = act { ActivateTabRelative = -1 } },
    { mods = M.cmd_mode, key = 'RightArrow', action = act { ActivateTabRelative = 1 } },
    { mods = M.leader_mode, key = '1', action = act.ActivateTab(0) },
    { mods = M.leader_mode, key = '2', action = act.ActivateTab(1) },
    { mods = M.leader_mode, key = '3', action = act.ActivateTab(2) },
    { mods = M.leader_mode, key = '4', action = act.ActivateTab(3) },
    { mods = M.leader_mode, key = '5', action = act.ActivateTab(4) },
    { mods = M.leader_mode, key = '6', action = act.ActivateTab(5) },
    { mods = M.leader_mode, key = '7', action = act.ActivateTab(6) },
    { mods = M.leader_mode, key = '8', action = act.ActivateTab(7) },
    { mods = M.leader_mode, key = '9', action = act.ActivateTab(8) },

    -- show the pane selection mode, but have it swap the active and selected panes
    { mods = M.leader_mode, key = 's', action = wezterm.action.PaneSelect { mode = 'Activate' } },
    -- Clipboard
    { mods = M.cmd_mode, key = 'c', action = act.CopyTo 'Clipboard' },
    { mods = M.cmd_mode, key = 'v', action = act.PasteFrom 'Clipboard' },
    { mods = M.leader_mode, key = 'Enter', action = act.ActivateCopyMode },
    { mods = M.leader_mode, key = 'f', action = act.Search 'CurrentSelectionOrEmptyString' },
    -- Panes
    { mods = M.leader_mode, key = 'z', action = act.TogglePaneZoomState },
    { mods = M.leader_mode, key = 'p', action = act.ActivateCommandPalette },
    { mods = M.leader_mode, key = 'd', action = act.ShowDebugOverlay },

    { mods = M.win_mode, key = 'LeftArrow', action = act.ActivatePaneDirection 'Prev' },
    { mods = M.win_mode, key = 'RightArrow', action = act.ActivatePaneDirection 'Next' },
    { mods = M.win_mode, key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { mods = M.win_mode, key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    -- Fonts
    { mods = M.cmd_mode, key = '+', action = act.IncreaseFontSize },
    { mods = M.cmd_mode, key = '-', action = act.DecreaseFontSize },
    -- Scroll
    { mods = M.cmd_mode, key = 'k', action = act.ClearScrollback 'ScrollbackAndViewport' },
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

  config.key_tables = {
    copy_mode = {
      { mods = 'NONE', key = 'Tab', action = act.CopyMode 'MoveForwardWord' },
      { mods = 'SHIFT', key = 'Tab', action = act.CopyMode 'MoveBackwardWord' },
      { mods = 'NONE', key = 'Enter', action = act.CopyMode 'MoveToStartOfNextLine' },
      { mods = 'NONE', key = 'Escape', action = act.CopyMode 'Close' },
      { mods = 'NONE', key = 'Space', action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { mods = 'NONE', key = '$', action = act.CopyMode 'MoveToEndOfLineContent' },
      { mods = 'SHIFT', key = '$', action = act.CopyMode 'MoveToEndOfLineContent' },
      { mods = 'NONE', key = ',', action = act.CopyMode 'JumpReverse' },
      { mods = 'NONE', key = '0', action = act.CopyMode 'MoveToStartOfLine' },
      { mods = 'NONE', key = ';', action = act.CopyMode 'JumpAgain' },
      {
        mods = 'NONE',
        key = 'F',
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      {
        mods = 'SHIFT',
        key = 'F',
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      { mods = 'NONE', key = 'G', action = act.CopyMode 'MoveToScrollbackBottom' },
      { mods = 'SHIFT', key = 'G', action = act.CopyMode 'MoveToScrollbackBottom' },
      { mods = 'NONE', key = 'H', action = act.CopyMode 'MoveToViewportTop' },
      { mods = 'SHIFT', key = 'H', action = act.CopyMode 'MoveToViewportTop' },
      { mods = 'NONE', key = 'L', action = act.CopyMode 'MoveToViewportBottom' },
      { mods = 'SHIFT', key = 'L', action = act.CopyMode 'MoveToViewportBottom' },
      { mods = 'NONE', key = 'M', action = act.CopyMode 'MoveToViewportMiddle' },
      { mods = 'SHIFT', key = 'M', action = act.CopyMode 'MoveToViewportMiddle' },
      { mods = 'NONE', key = 'O', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { mods = 'SHIFT', key = 'O', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      {
        mods = 'NONE',
        key = 'T',
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      {
        mods = 'SHIFT',
        key = 'T',
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      { mods = 'NONE', key = 'V', action = act.CopyMode { SetSelectionMode = 'Line' } },
      { mods = 'SHIFT', key = 'V', action = act.CopyMode { SetSelectionMode = 'Line' } },
      { mods = 'NONE', key = '^', action = act.CopyMode 'MoveToStartOfLineContent' },
      { mods = 'SHIFT', key = '^', action = act.CopyMode 'MoveToStartOfLineContent' },
      { mods = 'NONE', key = 'b', action = act.CopyMode 'MoveBackwardWord' },
      { mods = 'ALT', key = 'b', action = act.CopyMode 'MoveBackwardWord' },
      { mods = 'CTRL', key = 'b', action = act.CopyMode 'PageUp' },
      { mods = 'CTRL', key = 'c', action = act.CopyMode 'Close' },
      {
        mods = 'CTRL',
        key = 'd',
        action = act.CopyMode { MoveByPage = 0.5 },
      },
      {
        mods = 'NONE',
        key = 'e',
        action = act.CopyMode 'MoveForwardWordEnd',
      },
      {
        mods = 'NONE',
        key = 'f',
        action = act.CopyMode { JumpForward = { prev_char = false } },
      },
      { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      {
        mods = 'NONE',
        key = 'g',
        action = act.CopyMode 'MoveToScrollbackTop',
      },
      { mods = 'CTRL', key = 'g', action = act.CopyMode 'Close' },
      { mods = 'NONE', key = 'h', action = act.CopyMode 'MoveLeft' },
      { mods = 'NONE', key = 'j', action = act.CopyMode 'MoveDown' },
      { mods = 'NONE', key = 'k', action = act.CopyMode 'MoveUp' },
      { mods = 'NONE', key = 'l', action = act.CopyMode 'MoveRight' },
      { mods = 'ALT', key = 'm', action = act.CopyMode 'MoveToStartOfLineContent' },
      {
        mods = 'NONE',
        key = 'o',
        action = act.CopyMode 'MoveToSelectionOtherEnd',
      },
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
      {
        mods = 'NONE',
        key = 't',
        action = act.CopyMode { JumpForward = { prev_char = true } },
      },
      {
        mods = 'CTRL',
        key = 'u',
        action = act.CopyMode { MoveByPage = -0.5 },
      },
      {
        mods = 'NONE',
        key = 'v',
        action = act.CopyMode { SetSelectionMode = 'Cell' },
      },
      {
        mods = 'CTRL',
        key = 'v',
        action = act.CopyMode { SetSelectionMode = 'Block' },
      },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      {
        mods = 'NONE',
        key = 'y',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        },
      },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      {
        mods = 'ALT',
        key = 'LeftArrow',
        action = act.CopyMode 'MoveBackwardWord',
      },
      {
        mods = 'NONE',
        key = 'RightArrow',
        action = act.CopyMode 'MoveRight',
      },
      {
        mods = 'ALT',
        key = 'RightArrow',
        action = act.CopyMode 'MoveForwardWord',
      },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    },
  }
end

return M
