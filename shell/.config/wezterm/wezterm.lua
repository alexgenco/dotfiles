local wezterm = require("wezterm")
local act = wezterm.action
local cnf = wezterm.config_builder()

cnf:set_strict_mode(true)
cnf.font = wezterm.font("Berkeley Mono")
cnf.audible_bell = "Disabled"
cnf.use_fancy_tab_bar = false
cnf.tab_bar_at_bottom = true

-- adjust pane once, then enter resize_pane key table
function begin_resize(direction)
	return act.Multiple({
		act.AdjustPaneSize({ direction, 5 }),
		act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
			timeout_milliseconds = 3000,
			replace_current = false,
			until_unknown = true,
		}),
	})
end

wezterm.on("maximize-window", function(window, pane) window:maximize() end)

cnf.leader = { key = "a", mods = "CTRL" }
cnf.keys = {
	{ key = "=", mods = "CMD|OPT", action = act({ EmitEvent = "maximize-window" }) },
	-- tmux bindings
	{ key = "a", mods = "LEADER", action = act({ SendString = "\x01" }) },
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "|", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "[", mods = "LEADER", action = "ActivateCopyMode" },
	{ key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
	{ key = "p", mods = "LEADER", action = act({ ActivateTabRelative = -1 }) },
	{ key = "n", mods = "LEADER", action = act({ ActivateTabRelative = 1 }) },
	{ key = "P", mods = "LEADER", action = act({ MoveTabRelative = -1 }) },
	{ key = "N", mods = "LEADER", action = act({ MoveTabRelative = 1 }) },
	{ key = "H", mods = "LEADER", action = begin_resize("Left") },
	{ key = "L", mods = "LEADER", action = begin_resize("Right") },
	{ key = "J", mods = "LEADER", action = begin_resize("Down") },
	{ key = "K", mods = "LEADER", action = begin_resize("Up") },
	{ key = "a", mods = "LEADER|CTRL", action = act.ActivateLastTab },
	-- rename current tab
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Text = "rename tab:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}
cnf.key_tables = {
	resize_pane = {
		{ key = "H", action = act({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "L", action = act({ AdjustPaneSize = { "Right", 5 } }) },
		{ key = "K", action = act({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "J", action = act({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

return cnf
