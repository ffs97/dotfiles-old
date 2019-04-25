local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = require("helpers")
local pad = helpers.pad

-- Configuration
local playerctl_button_size = 50

local playerctl_toggle_icon = wibox.widget.imagebox(beautiful.playerctl_toggle_icon)
playerctl_toggle_icon.resize = true
playerctl_toggle_icon.forced_width = playerctl_button_size
playerctl_toggle_icon.forced_height = playerctl_button_size

playerctl_toggle_icon:buttons(gears.table.join(
	awful.button({ }, 1, function ()
		awful.spawn.with_shell("sp play")
	end)
))

local playerctl_prev_icon = wibox.widget.imagebox(beautiful.playerctl_prev_icon)
playerctl_prev_icon.resize = true
playerctl_prev_icon.forced_width = playerctl_button_size
playerctl_prev_icon.forced_height = playerctl_button_size

playerctl_prev_icon:buttons(gears.table.join(
	awful.button({ }, 1, function ()
		awful.spawn.with_shell("sp prev")
	end)
))

local playerctl_next_icon = wibox.widget.imagebox(beautiful.playerctl_next_icon)
playerctl_next_icon.resize = true
playerctl_next_icon.forced_width = playerctl_button_size
playerctl_next_icon.forced_height = playerctl_button_size

playerctl_next_icon:buttons(gears.table.join(
	awful.button({ }, 1, function ()
		awful.spawn.with_shell("sp next")
	end)
))

local playerctl_buttons = wibox.widget {
	pad(0),
	{
		playerctl_prev_icon,
		pad(1),
		playerctl_toggle_icon,
		pad(1),
		playerctl_next_icon,
		layout  = wibox.layout.fixed.horizontal
	},
	pad(0),
	expand = "none",
	layout = wibox.layout.align.horizontal,
}

return playerctl_buttons
