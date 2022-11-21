local wezterm = require "wezterm"

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local default_window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

local vim_window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

wezterm.on('update-status', function(window, pane)

  local overrides = window:get_config_overrides() or {}
  local info = pane:get_foreground_process_info()
  local executable = basename(info.executable)

  if executable == 'nvim' then
    overrides.window_padding = vim_window_padding
  else
    overrides.window_padding = default_window_padding
  end

  window:set_config_overrides(overrides)
end)

return {
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  font = wezterm.font("SFMono Nerd Font"),
  font_size = 11.0,
  use_resize_increments = true,
  hide_tab_bar_if_only_one_tab = true,
  window_close_confirmation = "NeverPrompt",
  use_fancy_tab_bar = false
}
