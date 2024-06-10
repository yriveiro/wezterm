local wezterm = require 'wezterm'

local act = wezterm.action
local M = {}

M.cmd_mode = 'CMD'
M.leader_mode = 'LEADER'
M.win_mode = 'ALT|SHIFT'

function M.setup(config)
  config.disable_default_key_bindings = true

  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

  config.keys = {
    -- New Tab
    { mods = M.leader_mode, key = 't', action = act.SpawnTab 'CurrentPaneDomain' },
    -- Splits
    { mods = M.leader_mode, key = '|', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { mods = M.leader_mode, key = '-', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Move Tabs
    { mods = M.leader_mode, key = '>', action = act.MoveTabRelative(1) },
    { mods = M.leader_mode, key = '<', action = act.MoveTabRelative(-1) },
    -- Activate Tabs
    { mods = M.leader_mode, key = 'l', action = act { ActivateTabRelative = 1 } },
    { mods = M.leader_mode, key = 'h', action = act { ActivateTabRelative = -1 } },
    -- show the pane selection mode, but have it swap the active and selected panes
    { mods = M.leader_mode, key = 's', action = wezterm.action.PaneSelect { mode = 'Activate' } },
    -- Clipboard
    { mods = M.cmd_mode, key = 'c', action = act.CopyTo 'Clipboard' },
    { mods = M.cmd_mode, key = 'v', action = act.PasteFrom 'Clipboard' },
    { mods = M.leader_mode, key = 'Space', action = act.QuickSelect },
    { mods = M.leader_mode, key = 'X', action = act.ActivateCopyMode },
    { mods = M.leader_mode, key = 'f', action = act.Search 'CurrentSelectionOrEmptyString' },
    -- Panes
    { mods = M.leader_mode, key = 'z', action = act.TogglePaneZoomState },
    { mods = M.leader_mode, key = 'p', action = act.ActivateCommandPalette },
    { mods = M.leader_mode, key = 'd', action = act.ShowDebugOverlay },

    { mods = M.win_mode, key = 'LeftArrow', action = act.ActivatePaneDirection 'Prev' },
    { mods = M.win_mode, key = 'RightArrow', action = act.ActivatePaneDirection 'Next' },
    { mods = M.win_mode, key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { mods = M.win_mode, key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },

    -- { mods = M.leader_mode, key = "ALT|LeftArrow", action = act.AdjustPaneSize({ "Left", 5 }) },
  }

  config.key_tables = {
    copy_mode = {
      { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      {
        key = 'Tab',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveBackwardWord',
      },
      {
        key = 'Enter',
        mods = 'NONE',
        action = act.CopyMode 'MoveToStartOfNextLine',
      },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      {
        key = 'Space',
        mods = 'NONE',
        action = act.CopyMode { SetSelectionMode = 'Cell' },
      },
      {
        key = '$',
        mods = 'NONE',
        action = act.CopyMode 'MoveToEndOfLineContent',
      },
      {
        key = '$',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToEndOfLineContent',
      },
      { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
      {
        key = 'F',
        mods = 'NONE',
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      {
        key = 'F',
        mods = 'SHIFT',
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      {
        key = 'G',
        mods = 'NONE',
        action = act.CopyMode 'MoveToScrollbackBottom',
      },
      {
        key = 'G',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToScrollbackBottom',
      },
      { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
      {
        key = 'H',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToViewportTop',
      },
      {
        key = 'L',
        mods = 'NONE',
        action = act.CopyMode 'MoveToViewportBottom',
      },
      {
        key = 'L',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToViewportBottom',
      },
      {
        key = 'M',
        mods = 'NONE',
        action = act.CopyMode 'MoveToViewportMiddle',
      },
      {
        key = 'M',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToViewportMiddle',
      },
      {
        key = 'O',
        mods = 'NONE',
        action = act.CopyMode 'MoveToSelectionOtherEndHoriz',
      },
      {
        key = 'O',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToSelectionOtherEndHoriz',
      },
      {
        key = 'T',
        mods = 'NONE',
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      {
        key = 'T',
        mods = 'SHIFT',
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      {
        key = 'V',
        mods = 'NONE',
        action = act.CopyMode { SetSelectionMode = 'Line' },
      },
      {
        key = 'V',
        mods = 'SHIFT',
        action = act.CopyMode { SetSelectionMode = 'Line' },
      },
      {
        key = '^',
        mods = 'NONE',
        action = act.CopyMode 'MoveToStartOfLineContent',
      },
      {
        key = '^',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToStartOfLineContent',
      },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      {
        key = 'd',
        mods = 'CTRL',
        action = act.CopyMode { MoveByPage = 0.5 },
      },
      {
        key = 'e',
        mods = 'NONE',
        action = act.CopyMode 'MoveForwardWordEnd',
      },
      {
        key = 'f',
        mods = 'NONE',
        action = act.CopyMode { JumpForward = { prev_char = false } },
      },
      { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      {
        key = 'g',
        mods = 'NONE',
        action = act.CopyMode 'MoveToScrollbackTop',
      },
      { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      {
        key = 'm',
        mods = 'ALT',
        action = act.CopyMode 'MoveToStartOfLineContent',
      },
      {
        key = 'o',
        mods = 'NONE',
        action = act.CopyMode 'MoveToSelectionOtherEnd',
      },
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
      {
        key = 't',
        mods = 'NONE',
        action = act.CopyMode { JumpForward = { prev_char = true } },
      },
      {
        key = 'u',
        mods = 'CTRL',
        action = act.CopyMode { MoveByPage = -0.5 },
      },
      {
        key = 'v',
        mods = 'NONE',
        action = act.CopyMode { SetSelectionMode = 'Cell' },
      },
      {
        key = 'v',
        mods = 'CTRL',
        action = act.CopyMode { SetSelectionMode = 'Block' },
      },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      {
        key = 'y',
        mods = 'NONE',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        },
      },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      {
        key = 'LeftArrow',
        mods = 'ALT',
        action = act.CopyMode 'MoveBackwardWord',
      },
      {
        key = 'RightArrow',
        mods = 'NONE',
        action = act.CopyMode 'MoveRight',
      },
      {
        key = 'RightArrow',
        mods = 'ALT',
        action = act.CopyMode 'MoveForwardWord',
      },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    },
  }
end

return M
