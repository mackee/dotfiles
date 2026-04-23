local wezterm = require 'wezterm'
local scheme = wezterm.get_builtin_color_schemes()["SynthwaveAlpha (Gogh)"]
local act = wezterm.action

return {
  font = wezterm.font("Moralerspace Neon NF"),
  use_ime = true,
  font_size = 11.0,
  cell_width = 1.1,
  color_scheme = "SynthwaveAlpha",
  --color_scheme = "Solarized Darcula",
  hide_tab_bar_if_only_one_tab = false,
  adjust_window_size_when_changing_font_size = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  colors = {
    tab_bar = {
      background = scheme.background,
      new_tab = { bg_color = "#2e3440", fg_color = scheme.ansi[8], intensity = "Bold" },
      new_tab_hover = { bg_color = scheme.ansi[1], fg_color = scheme.brights[8], intensity = "Bold" },
    },
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  leader = { key = 'z', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    { key = '1', mods = 'LEADER', action = act { ActivateTab = 0 }, },
    { key = '2', mods = 'LEADER', action = act { ActivateTab = 1 }, },
    { key = '3', mods = 'LEADER', action = act { ActivateTab = 2 }, },
    { key = '4', mods = 'LEADER', action = act { ActivateTab = 3 }, },
    { key = '5', mods = 'LEADER', action = act { ActivateTab = 4 }, },
    { key = '6', mods = 'LEADER', action = act { ActivateTab = 5 }, },
    { key = '7', mods = 'LEADER', action = act { ActivateTab = 6 }, },
    { key = '8', mods = 'LEADER', action = act { ActivateTab = 7 }, },
    { key = '9', mods = 'LEADER', action = act { ActivateTab = 8 }, },
    {
      key = 'v',
      mods = 'LEADER',
      action = act.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = 'H',
      mods = 'LEADER',
      action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = 'h',
      mods = 'LEADER',
      action = act { ActivatePaneDirection = "Left" },
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = act { ActivatePaneDirection = "Down" },
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = act { ActivatePaneDirection = "Up" },
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = act { ActivatePaneDirection = "Right" },
    },
    {
      key = 'LeftArrow',
      mods = 'SHIFT',
      action = act { ActivatePaneDirection = "Left" },
    },
    {
      key = 'DownArrow',
      mods = 'SHIFT',
      action = act { ActivatePaneDirection = "Next" },
    },
    {
      key = 'UpArrow',
      mods = 'SHIFT',
      action = act { ActivatePaneDirection = "Prev" },
    },
    {
      key = 'RightArrow',
      mods = 'SHIFT',
      action = act { ActivatePaneDirection = "Right" },
    },
    {
      key = 'c',
      mods = 'LEADER',
      action = act { SpawnTab = "CurrentPaneDomain" },
    },
    {
      key = 'h',
      mods = 'LEADER|CTRL',
      action = act.Multiple {
        act.AdjustPaneSize { "Left", 5 },
        act.ActivateKeyTable {
          name = "resize_pane",
          one_shot = false,
          until_unkown = true,
          replace_current = true,
          prevent_fallback = false,
          timeout_milliseconds = 1000,
        },
      },
    },
    {
      key = 'j',
      mods = 'LEADER|CTRL',
      action = act.Multiple {
        act.AdjustPaneSize { "Down", 5 },
        act.ActivateKeyTable {
          name = "resize_pane",
          one_shot = false,
          until_unkown = true,
          replace_current = true,
          prevent_fallback = false,
          timeout_milliseconds = 1000,
        },
      },
    },
    {
      key = 'k',
      mods = 'LEADER|CTRL',
      action = act.Multiple {
        act.AdjustPaneSize { "Up", 5 },
        act.ActivateKeyTable {
          name = "resize_pane",
          one_shot = false,
          until_unkown = true,
          replace_current = true,
          prevent_fallback = false,
          timeout_milliseconds = 1000,
        },
      },
    },
    {
      key = 'l',
      mods = 'LEADER|CTRL',
      action = act.Multiple {
        act.AdjustPaneSize { "Right", 5 },
        act.ActivateKeyTable {
          name = "resize_pane",
          one_shot = false,
          until_unkown = true,
          replace_current = true,
          prevent_fallback = false,
          timeout_milliseconds = 1000,
        },
      },
    },
    {
      key = '[',
      mods = 'LEADER',
      action = act.ActivateCopyMode,
    },
    {
      key = 'r',
      mods = 'LEADER',
      action = act.RotatePanes 'CounterClockwise',
    },
  },
  key_tables = {
    resize_pane = {
      {
        key = 'h',
        mods = 'CTRL',
        action = act.AdjustPaneSize { "Left", 5 },
      },
      {
        key = 'j',
        mods = 'CTRL',
        action = act.AdjustPaneSize { "Down", 5 },
      },
      {
        key = 'k',
        mods = 'CTRL',
        action = act.AdjustPaneSize { "Up", 5 },
      },
      {
        key = 'l',
        mods = 'CTRL',
        action = act.AdjustPaneSize { "Right", 5 },
      },
    },
  },
}
