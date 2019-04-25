local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
local title_color =  beautiful.spotify_song_title_color or beautiful.wibar_fg
local artist_color = beautiful.spotify_song_artist_color or beautiful.wibar_fg
local paused_color = beautiful.spotify_song_paused_color or beautiful.normal_fg

local spotify_title = wibox.widget{
	text = "---------",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
	font = beautiful.font .. " 13",
	forced_height = 22
}

local spotify_artist = wibox.widget{
	text = "---------",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
	font = beautiful.font .. " 12",
	forced_height = 22
}

-- Main widget
local spotify_song = wibox.widget{
	spotify_title,
	spotify_artist,
	layout = wibox.layout.fixed.vertical
}

local artist_fg
local artist_bg

local function update_widget(line)
	local status = line:match("^[^|]+")

	if status ~= "Stopped" then
		local artist = line:match('|[^|]+|')
		local title = line:match('|[^|]+$')

		artist = artist:gsub("|", "")
		title = title:gsub("|", "")
		
	 	--Escape &'s
		artist = artist:gsub("&", "&amp;")
		title = title:gsub("&", "&amp;")

		if status == "Paused" then
			artist_fg = paused_color
			title_fg = paused_color
		else
			artist_fg = artist_color
			title_fg = title_color
		end

		spotify_artist.markup = "<span foreground='" .. artist_fg .."'>" .. artist .. "</span>"
		spotify_title.markup = "<span foreground='" .. title_fg .."'>" .. title .. "</span>"
	else
		spotify_artist.markup = "---------"
		spotify_title.markup = "---------"
	end

end

-- Sleeps until spotify changes state
local spotify_script = [[
	bash -c '
		sp subscribe
	'
]]

awful.spawn.with_line_callback(spotify_script, {
	stdout = function(line)
		update_widget(line)
	end
})

spotify_song:buttons(gears.table.join(
	awful.button({ }, 1, function ()
		awful.spawn.with_shell("mpc toggle")
	end),
	awful.button({ }, 3, function ()
		awful.spawn(terminal .. " -e ncmpcpp", {floating = true})
	end),
	awful.button({ }, 4, function ()
		awful.spawn.with_shell("mpc prev")
	end),
	awful.button({ }, 5, function ()
		awful.spawn.with_shell("mpc next")
	end)
))

return spotify_song
