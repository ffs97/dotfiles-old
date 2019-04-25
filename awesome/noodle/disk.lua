local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = require("helpers")
local pad = helpers.pad

-- Configuration
local update_interval = 10            -- in seconds

local disk = wibox.widget{
	text = "free disk space",
	align  = "center",
	valign = "center",
	widget = wibox.widget.textbox,
	font = beautiful.font .. " 13"
}

local disk_icon = wibox.widget.imagebox(beautiful.files_icon)
disk_icon.resize = true
disk_icon.forced_width = 40
disk_icon.forced_height = 40

local function update_widget(disk_space)
	disk.markup = disk_space .. "B Free"
end

-- Use /dev/sdXY according to your setup
local disk_script = [[
bash -c "
df -k -h /dev/sda1 | tail -1 | awk '{print $4}'
"]]

awful.widget.watch(disk_script, update_interval, function(widget, stdout)
	local disk_space = stdout
	-- Remove trailing white space
	disk_space = string.gsub(disk_space, '^%s*(.-)%s*$', '%1')
	update_widget(disk_space)
end)

local disk_widget = wibox.widget{
	pad(0),
	{
		disk_icon,
		disk,
		layout = wibox.layout.fixed.horizontal
	},
	pad(0),
	expand = "none",
	layout = wibox.layout.align.horizontal
}

disk_widget:buttons(
	gears.table.join(
		awful.button({ }, 1, function ()
			awful.spawn(filemanager, {floating = true})
		end)
	)
)

return disk_widget
