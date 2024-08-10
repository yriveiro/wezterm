local wezterm = require 'wezterm'

local act = wezterm.action
local M = {}

function M.setup(config)
  config.key_tables = config.key_tables or {}

  config.key_tables['copy_mode'] = {
    { mods = 'NONE', key = 'Tab', action = act.CopyMode 'MoveForwardWord' },
    { mods = 'SHIFT', key = 'Tab', action = act.CopyMode 'MoveBackwardWord' },
    { mods = 'NONE', key = 'Enter', action = act.CopyMode 'MoveToStartOfNextLine' },
    { mods = 'NONE', key = 'Escape', action = act.CopyMode 'Close' },
    {
      mods = 'NONE',
      key = 'Space',
      action = act.CopyMode { SetSelectionMode = 'Cell' },
    },
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

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  }
end

return M
