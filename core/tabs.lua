local ipairs = ipairs
local wezterm = require 'wezterm'

local M = {}

M.arrow_solid = ''
M.arrow_thin = ''

M.icons = {
  ['debug'] = wezterm.nerdfonts.dev_terminal,
  ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
  ['btm'] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ['btop'] = wezterm.nerdfonts.md_chart_areaspline,
  ['cargo'] = wezterm.nerdfonts.dev_rust,
  ['curl'] = wezterm.nerdfonts.mdi_flattr,
  ['docker'] = wezterm.nerdfonts.linux_docker,
  ['docker-compose'] = wezterm.nerdfonts.linux_docker,
  ['gh'] = wezterm.nerdfonts.dev_github_badge,
  ['git'] = wezterm.nerdfonts.dev_git,
  ['go'] = wezterm.nerdfonts.seti_go,
  ['htop'] = wezterm.nerdfonts.md_chart_areaspline,
  ['kubectl'] = wezterm.nerdfonts.linux_docker,
  ['lazydocker'] = wezterm.nerdfonts.linux_docker,
  ['lazygit'] = wezterm.nerdfonts.cod_github,
  ['lua'] = wezterm.nerdfonts.seti_lua,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['node'] = wezterm.nerdfonts.mdi_hexagon,
  ['nvim'] = wezterm.nerdfonts.custom_vim,
  ['psql'] = wezterm.nerdfonts.dev_postgresql,
  ['sudo'] = wezterm.nerdfonts.fa_hashtag,
  ['vim'] = wezterm.nerdfonts.dev_vim,
  ['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
  ['zsh'] = wezterm.nerdfonts.dev_terminal,
}

function M.title(tab, max_width)
  local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or tab.active_pane.title
  local process, other = title:match '^(%S+)%s*%-?%s*%s*(.*)$'
  local icon = ''

  if M.icons[string.lower(process)] then
    icon = M.icons[process] .. ' ' .. (other or '')
  end

  local is_zoomed = false

  for _, pane in ipairs(tab.panes) do
    if pane.is_zoomed then
      is_zoomed = true
      break
    end
  end

  if is_zoomed then -- or (#tab.panes > 1 and not tab.is_active) then
    title = ' ' .. title
  end

  title = wezterm.truncate_right(title, max_width - 3)

  return ' ' .. icon .. title .. ' '
end

function M.tab_current_idx(tabs, tab)
  local tab_idx = 1

  for i, t in ipairs(tabs) do
    if t.tab_id == tab.tab_id then
      tab_idx = i
      break
    end
  end

  return tab_idx
end

function M.setup(config)
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true
  config.hide_tab_bar_if_only_one_tab = false
  config.tab_max_width = 32
  config.unzoom_on_switch_pane = true

  ---@diagnostic disable-next-line: unused-local, redefined-local
  wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local tab_bar = config.color_schemes[config.color_scheme].tab_bar

    local active_bg = tab_bar.active_tab.bg_color
    local active_fg = tab_bar.active_tab.fg_color
    local inactive_bg = tab_bar.inactive_tab.bg_color
    local inactive_fg = tab_bar.inactive_tab.fg_color

    local title = M.title(tab, max_width)
    local tab_idx = M.tab_current_idx(tabs, tab)

    local is_last = tab_idx == #tabs
    local is_first = tab_idx == 1
    local next_tab = tabs[tab_idx + 1]

    local ret = nil

    if tab.is_active then
      ret = {
        { Background = { Color = active_bg } },
        { Foreground = { Color = active_fg } },
        { Attribute = { Intensity = 'Bold' } },
        { Text = ' ' .. tab_idx .. ' ' .. M.arrow_thin .. title },
        { Background = { Color = tab_bar.background } },
        { Foreground = { Color = tab_bar.active_tab.bg_color } },
        { Text = M.arrow_solid },
        { Background = { Color = is_last and tab_bar.background or tab_bar.inactive_tab.bg_color } },
        { Foreground = { Color = tab_bar.background } },
        { Text = M.arrow_solid },
      }
    elseif is_first then
      ret = {
        { Background = { Color = inactive_bg } },
        { Foreground = { Color = inactive_fg } },
        { Text = ' ' .. tab_idx .. ' ' .. M.arrow_thin .. title },
        { Background = { Color = tab_bar.background } },
        { Foreground = { Color = tab_bar.inactive_tab.bg_color } },
        { Text = M.arrow_solid },
        {
          Background = {
            Color = tab.is_active and tab_bar.active_tab.bg_color
              or next_tab.is_active and tab_bar.active_tab.bg_color
              or tab_bar.inactive_tab.bg_color,
          },
        },
        { Foreground = { Color = tab_bar.background } },
        { Text = M.arrow_solid },
      }
    elseif is_last then
      ret = {
        { Background = { Color = inactive_bg } },
        { Foreground = { Color = inactive_fg } },
        { Text = ' ' .. tab_idx .. ' ' .. M.arrow_thin .. title },
        { Background = { Color = tab_bar.background } },
        { Foreground = { Color = tab_bar.inactive_tab.bg_color } },
        { Text = M.arrow_solid },
        { Background = { Color = tab_bar.background } },
        { Foreground = { Color = tab_bar.background } },
        { Text = M.arrow_solid },
      }
    else
      ret = {
        { Background = { Color = inactive_bg } },
        { Foreground = { Color = inactive_fg } },
        { Text = ' ' .. tab_idx .. ' ' .. M.arrow_thin .. title },
        { Background = { Color = tab_bar.background } },
        { Foreground = { Color = tab_bar.inactive_tab.bg_color } },
        { Text = M.arrow_solid },
        {
          Background = {
            Color = next_tab.is_active and tab_bar.active_tab.bg_color or tab_bar.inactive_tab.bg_color,
          },
        },
        { Foreground = { Color = tab_bar.background } },
        { Text = M.arrow_solid },
      }
    end

    return ret
  end)
end

return M
