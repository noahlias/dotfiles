local wezterm = require("wezterm")

local process_icons = require("icons")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
	config:set_strict_mode(false)
end
local function get_proc_title(pane)
	return (pane.title or pane:get_foreground_process_name()):gsub("^%s+", ""):gsub("%s+$", ""):match("[^/]+$")
end

local act = wezterm.action

config = {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"Hack Nerd Font",
		"Symbols Nerd Font",
		-- "Maple Mono",
		-- "Monaspace Radon",
		"Fusion Kai G",
	}),
	front_end = "WebGpu",
	color_scheme = "Catppuccin Mocha",
	animation_fps = 30,
	max_fps = 60,
	font_size = 14.0,
	underline_thickness = 1,
	underline_position = -2.0,
	allow_square_glyphs_to_overflow_width = "Never",
	-- colors = { background = "#26283f" },
	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 1.0,
	},
	enable_tab_bar = true,
	window_decorations = "RESIZE",
	-- hide_tab_bar_if_only_one_tab = true,
	-- window_background_opacity = 0.9,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 30,
	enable_kitty_keyboard = true,
	warn_about_missing_glyphs = false,
	window_frame = {
		font = wezterm.font({ family = "Monaspace Radon", weight = "Bold" }),
		font_size = 13.0,
		border_left_width = "0.0cell",
		border_right_width = "0.0cell",
		border_bottom_height = "0.10cell",
		border_bottom_color = "#1a1b26",
		border_top_height = "0.0cell",
	},
	launch_menu = {},
	mouse_bindings = {
		{
			event = {
				Down = { streak = 1, button = "Right" },
			},
			mods = "NONE",
			action = wezterm.action_callback(function(window, pane)
				local has_selection = window:get_selection_text_for_pane(pane) ~= ""
				if has_selection then
					window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
					window:perform_action(act.ClearSelection, pane)
				else
					window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
				end
			end),
		},
	},
}

package.loaded.nvim = nil
package.loaded.keymap = nil
local nvim = require("nvim")
local keymap = require("keymap")

config.bypass_mouse_reporting_modifiers = "SHIFT"

config.keys = {}

nvim.apply_mappings(config.keys)
keymap.apply_mappings(config.keys)

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, hover, _max_width)
	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end
	local proc_title = get_proc_title(tab.active_pane)

	local icon
	if process_icons[proc_title] ~= nil then
		icon = wezterm.format({
			{ Text = " " },
			process_icons[proc_title],
			{ Text = " " },
		})
	else
		icon = wezterm.format({
			{ Text = string.format(" %s", proc_title) },
		})
	end
	local title = {}
	if hover then
		table.insert(title, {
			Background = { Color = "#2a2e36" },
		})
	else
		table.insert(title, {
			Background = { Color = "#1a1b26" },
		})
	end
	if has_unseen_output then
		table.insert(title, {
			Foreground = { Color = "#fffac2" },
		})
	elseif tab.is_active then
		table.insert(title, {
			Foreground = { Color = "#5de4c7" },
		})
	else
		table.insert(title, {
			Foreground = { Color = "#9196c2" },
		})
	end
	table.insert(title, {
		Text = icon,
	})
	table.insert(title, {
		Foreground = {
			Color = "#9196c2",
		},
	})
	if tab.tab_title == "" then
		table.insert(title, {
			Text = proc_title or "",
		})
	else
		table.insert(title, {
			Text = tab.tab_title,
		})
	end
	table.insert(title, {
		Text = " ",
	})
	return title
end)

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = "#9196c2" } },
		{
			Text = (function()
				if pane:get_user_vars().IS_NVIM == "true" then
					return ""
				else
					return ""
				end
			end)(),
		},
		{ Text = wezterm.strftime("%l:%M %p") },
	}))
end)

-- wezterm.on("augment-command-palette", function(_window, _pane)
-- 	return {
-- 		sesh.create,
-- 		sesh.attach,
-- 	}
-- end)

-- wezterm.on("new-tab-button-click", function(window, pane, button, _default_action)
-- 	if button == "Left" then
-- 		window:perform_action(sesh.create.action, pane)
-- 		return false
-- 	end
-- end)

-- wezterm.on("window-focus-changed", function(window)
-- 	we["WEZTERM_TAB"] = window:active_tab():tab_id()
-- end)

-- local mux = wezterm.mux
-- wezterm.on("gui-attached", function()
-- 	local workspace = mux.get_active_workspace()
-- 	for _, win in ipairs(mux.all_windows()) do
-- 		if win:get_workspace() == workspace then
-- 			config.set_environment_variables.WEZTERM_TAB = win:active_tab()
-- 		end
-- 	end
-- end)

config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
		format = "$0",
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
	{ regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], format = "mailto:$0" },
	-- file:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{ regex = [[\bfile://\S*\b]], format = "$0" },
}

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
	regex = [[[^:]["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	format = "https://www.github.com/$1/$3",
})

-- localhost, with protocol, with optional port and path
table.insert(config.hyperlink_rules, {
	regex = [[http(s)?://localhost(?>:\d+)?]],
	format = "http$1://localhost:$2",
})

-- localhost with no protocol, with optional port and path
table.insert(config.hyperlink_rules, {
	regex = [[[^/]localhost:(\d+)(\/\w+)*]],
	format = "http://localhost:$1",
})
return config
