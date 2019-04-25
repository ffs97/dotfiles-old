-- Helper Libraries {{
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = require("helpers")
local pad = helpers.pad
-- }}

-- Item configuration

--local weather_widget = require("noodle.weather")

local playerctl_buttons = require("noodle.player")
local spotify = require("noodle.spotify")

local cpu_widget = require("noodle.cpu")
local ram_widget = require("noodle.ram")
local volume_widget = require("noodle.volume")
local battery_widget = require("noodle.battery")
local temperature_widget = require("noodle.temperature")

local disk_widget = require("noodle.disk")

local time = wibox.widget.textclock("%H %M")
time.align = "center"
time.valign = "center"
time.font = "sans 50"

local date = wibox.widget.textclock("%A, %B %d")
-- local date = wibox.widget.textclock("%A, %B %d, %Y")
date.align = "center"
date.valign = "center"
date.font = "sans medium 15"

local fancy_date = wibox.widget.textclock("%-j days around the sun")
fancy_date.align = "center"
fancy_date.valign = "center"
fancy_date.font = "sans 11"

-- Create the sidebar
sidebar = wibox({x = 0, y = 0, visible = false, ontop = true, type = "dock"})

sidebar.bg = beautiful.sidebar_bg or beautiful.wibar_bg or "#111111"
sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
sidebar.opacity = beautiful.sidebar_opacity or 1
sidebar.height = beautiful.sidebar_height or awful.screen.focused().geometry.height
sidebar.width = beautiful.sidebar_width or 300
sidebar.y = beautiful.sidebar_y or 0
local radius = beautiful.sidebar_border_radius or 0
if beautiful.sidebar_position == "right" then
	sidebar.x = awful.screen.focused().geometry.width - sidebar.width
	sidebar.shape = helpers.prrect(radius, true, false, false, true)
else
	sidebar.x = 0
	sidebar.shape = helpers.prrect(radius, false, true, true, false)
end

sidebar:buttons(gears.table.join(
-- Middle click - Hide sidebar
awful.button({ }, 2, function ()
	sidebar.visible = false
end)
))

-- Hide sidebar when mouse leaves
if beautiful.sidebar_hide_on_mouse_leave then
	sidebar:connect_signal("mouse::leave", function ()
		sidebar.visible = false
	end)
end
-- Activate sidebar by moving the mouse at the edge of the screen
if beautiful.sidebar_hide_on_mouse_leave then
	local sidebar_activator = wibox({y = 0, width = 1, height = awful.screen.focused().geometry.height, visible = true, ontop = false, opacity = 0, below = true})
	sidebar_activator:connect_signal("mouse::enter", function ()
		sidebar.visible = true
	end)

	if beautiful.sidebar_position == "right" then
		sidebar_activator.x = awful.screen.focused().geometry.width - sidebar_activator.width
	else
		sidebar_activator.x = 0
	end

	sidebar_activator:buttons(
	gears.table.join(
	awful.button({ }, 2, function ()
		sidebar.visible = not sidebar.visible
	end),
	awful.button({ }, 4, function ()
		awful.tag.viewprev()
	end),
	awful.button({ }, 5, function ()
		awful.tag.viewnext()
	end)
	))
end

-- Item placement
sidebar:setup {
	{ ----------- TOP GROUP -----------
		pad(1),
		pad(1),
		time,
		date,
		fancy_date,
		--pad(1),
		--pad(1),
		--weather_widget,
		--pad(1),
		--pad(1),
		layout = wibox.layout.fixed.vertical
	},
	{ ----------- MIDDLE GROUP -----------
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		pad(1),
		playerctl_buttons,
		pad(1),
		{
			pad(2),
			spotify,
			pad(2),
			layout = wibox.layout.align.horizontal,
		},
		layout = wibox.layout.fixed.vertical
	},
	{ ----------- BOTTOM GROUP -----------
		disk_widget,
		pad(1),
		pad(1),
		volume_widget,
		battery_widget,
		cpu_widget,
		ram_widget,
		temperature_widget,
		pad(2),
		pad(2),
		pad(1),
		layout = wibox.layout.fixed.vertical
	},
	layout = wibox.layout.align.vertical,
}
