-- https://hackernoon.com/get-the-most-out-of-your-terminal-a-comprehensive-guide-to-wezterm-configuration
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local config = {}

wezterm.on('gui-startup', function()
    local tab, pane, window = mux.spawn_window({})
    window:gui_window():maximize()
end)

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_prog = {'pwsh'}
-- config.window_decorations = 'RESIZE'

-- BEHAVIOUR
config.check_for_updates = true

-- FONT
config.font = wezterm.font('IosevkaTerm Nerd Font')
config.font_size = 12.0
config.window_frame = {
    font = wezterm.font {
        family = 'IosevkaTerm Nerd Font Mono',
        weight = 'Regular'
    }
}

-- WINDOW APPEARANCE
config.color_scheme = 'Ayu Mirage'
config.window_background_opacity = 0
config.win32_system_backdrop = 'Mica'
config.enable_scroll_bar = true
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
wezterm.on('toggle-opacity', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = 0.5
    else
        overrides.window_background_opacity = nil
    end
    window:set_config_overrides(overrides)
end)
config.keys = {{
    key = 'B',
    mods = 'CTRL',
    action = wezterm.action.EmitEvent 'toggle-opacity'
}, {
    key = 'r',
    mods = 'CTRL|ALT|SHIFT',
    action = act.ReloadConfiguration
}, {
    key = 'w',
    mods = 'CTRL',
    action = act.CloseCurrentTab {
        confirm = false
    }
}}

return config
