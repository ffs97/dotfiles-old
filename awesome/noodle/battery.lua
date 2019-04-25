local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = require("helpers")
local pad = helpers.pad

-- Set colors
local active_color = beautiful.battery_bar_active_color or "#5AA3CC"
local background_color = beautiful.battery_bar_background_color or "#222222"

-- Configuration
local update_interval = 100            -- in seconds

local battery_bar = wibox.widget{
	max_value     = 100,
	value         = 50,
	forced_height = 10,
	margins       = {
		top = 10,
		bottom = 10
	},
	forced_width  = 200,
	shape         = gears.shape.rounded_bar,
	bar_shape     = gears.shape.rounded_bar,
	color         = active_color,
	background_color = background_color,
	border_width  = 0,
	border_color  = beautiful.border_color,
	widget        = wibox.widget.progressbar,
}

local battery_icon = wibox.widget.imagebox(beautiful.battery_icon)
battery_icon.resize = true
battery_icon.forced_width = 40
battery_icon.forced_height = 40

local function update_widget(bat, state)
	battery_bar.value = tonumber(bat)
	
	if state == "discharging" then
		battery_icon.image = beautiful.battery_icon
	else
		battery_icon.image = beautiful.battery_charging_icon
	end
end

local bat_script = [[
	bash -c "
		upower -i $(upower -e | grep BAT) | grep -E 'percentage|state' | awk '{print $2}' | tr $'\n' ' '
	"
]]

awful.widget.watch(bat_script, update_interval, function(widget, stdout)
	stdout = stdout:gsub("%%", "")
	
	local bat = stdout:match("[0-9]+")
	local state = stdout:match("[^ ]+")

	update_widget(bat, state)
end)

local battery = wibox.widget{
	pad(0),
	{
		battery_icon,
		pad(1),
		battery_bar,
		layout = wibox.layout.fixed.horizontal
	},
	pad(0),
	expand = "none",
	layout = wibox.layout.align.horizontal
}

return battery
