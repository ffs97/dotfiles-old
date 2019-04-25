--   ███████              ███                                                                                                
--  ░███░░███            ░███                                                                                                
--  ░███ ░░░   ██████   ░██████          ██████    ████    ██    ████   ██████    █████   ██████   ██████████████    ██████  
--  ██████    ░░░░░███   ░███░          ░░░░░███  ░░███   ████   ███   ███░░███ ░███░░   ███░░███ ░░███░░███░░███   ███░░███ 
-- ░░███░      ███████   ░███     █████  ███████   ░░███ ██████ ███   ░███████   ░████  ░███ ░███  ░███ ░███ ░███  ░███████  
--  ░███      ███░░███   ░███  █ ░░░░░  ███░░███    ░░█████░░█████    ░███░░░    ░░░███ ░███ ░███  ░███ ░███ ░███  ░███░░░   
--  █████     ░████████  ░░████         ░████████    ░░███  ░░███     ░░███████  █████  ░░██████   █████░███ █████ ░░███████ 
-- ░░░░░      ░░░░░░░░   ░░░░░          ░░░░░░░░      ░░░    ░░░       ░░░░░░░  ░░░░░    ░░░░░░   ░░░░░ ░░░ ░░░░░   ░░░░░░░  
----------------------------------------------------------------------------------------------------

local theme_name = "fat-awesome"
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local icon_path = theme_dir .. "/icons/"
local layout_icon_path = theme_dir .. "/layout/"
local weather_icon_path = theme_dir .. "/weather/"
local taglist_icon_path = theme_dir .. "/taglist/"
local titlebar_icon_path = theme_dir .. "/titlebar/"
local tip = titlebar_icon_path --alias to save time/space
local xrdb = xresources.get_current_theme()
-- local theme = dofile(themes_path.."default/theme.lua")
local theme = {}

-- theme.tip = titlebar_icon_path -- NOT local so that scripts can access it

-- This is used to make it easier to align the panels in specific monitor positions
local awful = require("awful")
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/wall.png"

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
-- theme.font          = "sans 11"
theme.font      = "IBM Plex Mono Medium"
theme.font_size = "13"

-- Set colors
local color0      = "#282A36"
local color1      = "#F37F97"
local color2      = "#5ADECD"
local color3      = "#F2A272"
local color4      = "#8897F4"
local color5      = "#C574DD"
local color6      = "#79E6F3"
local color7      = "#FDFDFD"
local color8      = "#414458"
local color9      = "#FF4971"
local color10     = "#18E3C8"
local color11     = "#FF8037"
local color12     = "#556FFF"
local color13     = "#B043D1"
local color14     = "#3FDCEE"
local color15     = "#BEBEC1"
local background  = "#1B1D26"
local xforeground = "#FDFDFD"

-- Set some colors that are used frequently as local variables
local accent_color = color14
local focused_color = color14
local unfocused_color = color7
local urgent_color = color9

-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark       = background
theme.bg_normal     = background
theme.bg_focus      = background 
theme.bg_urgent     = background
theme.bg_minimize   = color8
theme.bg_systray    = background

theme.fg_normal     = color7
theme.fg_focus      = focused_color
theme.fg_urgent     = urgent_color
theme.fg_minimize   = color8

-- Gaps
theme.useless_gap   = dpi(10)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(20)

-- Borders
theme.border_width  = dpi(0)
theme.border_color = color0
theme.border_normal = color0
theme.border_focus  = color0
-- Rounded corners
theme.border_radius = dpi(6)

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = true
theme.titlebar_size = dpi(35)
theme.titlebar_title_enabled = true
theme.titlebar_font = theme.font .. " 11"
-- Window title alignment: left, right, center
theme.titlebar_title_align = "center"
-- Titlebar position: top, bottom, left, right
theme.titlebar_position = "top"
-- Use 4 titlebars around the window to imitate borders
theme.titlebars_imitate_borders = false
theme.titlebar_bg = color0
theme.titlebar_bg_focus = background
-- theme.titlebar_bg_normal = color13
theme.titlebar_fg_focus = color7
theme.titlebar_fg_normal = color15
--theme.titlebar_fg = color7

-- Notifications
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position = "top_right" -- BUG: some notifications appear at top_right regardless
theme.notification_border_width = 0
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = color10
theme.notification_bg = background
theme.notification_fg = color7
theme.notification_crit_bg = urgent_color
theme.notification_crit_fg = color0
theme.notification_icon_size = dpi(60)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
theme.notification_margin = dpi(30)
theme.notification_opacity = 0.95
theme.notification_font = theme.font .. " 11"
theme.notification_padding = dpi(10) 
theme.notification_spacing = dpi(10)

-- Edge snap
theme.snap_bg = theme.bg_focus
if theme.border_width == 0 then
    theme.snap_border_width = dpi(8)
else
    theme.snap_border_width = theme.border_width * 2
end
-- Doesnt work with 4.2, need awesome-git?
--theme.snapper_gap = theme.useless_gap

-- Tag names
theme.tagnames = {
  "1",    -- tag 1
  "2",    -- tag 2
  "3",	  -- tag 3
  "4",	  -- tag 4
  "5",	  -- tag 5
  "6",	  -- tag 6
  "7",	  -- tag 7
  "8",	  -- tag 8
}

-- Widget separator
theme.separator_text = "|"
--theme.separator_text = " :: "
--theme.separator_text = " • "
-- theme.separator_text = " •• "
theme.separator_fg = color8

-- Wibar(s)
-- (Bar items can be customized in bars.lua)
theme.wibar_position = "bottom"
theme.wibar_detached = false
theme.wibar_height = dpi(45)
theme.wibar_fg = color7
theme.wibar_bg = color0 .. "00"
--theme.wibar_opacity = 0.7
theme.wibar_border_color = color0
theme.wibar_border_width = 0
theme.wibar_border_radius = 0
theme.wibar_border_radius = theme.border_radius
--theme.wibar_width = screen_width - theme.screen_margin * 4 -theme.wibar_border_width * 2

theme.wibar_width = 620
theme.wibar_x = (screen_width - theme.wibar_width) / 2 - theme.screen_margin
theme.wibar_y = screen_height - 40

-- Widgets
theme.prefix_fg = color8

 --There are other variable sets
 --overriding the default one when
 --defined, the sets are:
 --taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
 --tasklist_[bg|fg]_[focus|urgent]
 --titlebar_[bg|fg]_[normal|focus]
 --tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
 --mouse_finder_[color|timeout|animate_timeout|radius|factor]
 --prompt_[fg|bg|fg_cursor|bg_cursor|font]
 --hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
 --Example:
--theme.taglist_bg_focus = "#ff0000"

 --Tasklist
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = color0 .. "00"
theme.tasklist_fg_focus = focused_color
theme.tasklist_bg_normal = color0 .. "00"
theme.tasklist_fg_normal = unfocused_color
theme.tasklist_bg_minimize = color0 .. "00"
theme.tasklist_fg_minimize = theme.fg_minimize
theme.tasklist_bg_urgent = color0 .. "00"
theme.tasklist_fg_urgent = urgent_color
theme.tasklist_spacing = 5
theme.tasklist_align = "center"

-- Sidebar
-- (Sidebar items can be customized in sidebar.lua)
theme.sidebar_bg = background
theme.sidebar_bg_alt = color0
theme.sidebar_fg = color7
theme.sidebar_opacity = 1
theme.sidebar_position = "left" -- left or right
theme.sidebar_width = 300
theme.sidebar_height = screen_height
theme.sidebar_y = 0
theme.sidebar_border_radius = 0
theme.sidebar_hide_on_mouse_leave = true
theme.sidebar_show_on_mouse_edge = true

-- Exit screen
theme.exit_screen_bg = color0 .. "DA"
theme.exit_screen_fg = color7
theme.exit_screen_font = theme.font .. " 14"
theme.exit_screen_icon_size = 140

-- Other icons (mostly used in sidebar and menu)
theme.playerctl_toggle_icon = icon_path .. "playerctl_toggle.png"
theme.playerctl_prev_icon = icon_path .. "playerctl_prev.png"
theme.playerctl_next_icon = icon_path .. "playerctl_next.png"
theme.stats_icon = icon_path .. "stats.png"
theme.search_icon = icon_path .. "search.png"
theme.volume_icon = icon_path .. "volume.png"
theme.muted_icon = icon_path .. "muted.png"
theme.firefox_icon = icon_path .. "firefox.png"
theme.youtube_icon = icon_path .. "youtube.png"
theme.reddit_icon = icon_path .. "reddit.png"
theme.discord_icon = icon_path .. "discord.png"
theme.telegram_icon = icon_path .. "telegram.png"
theme.steam_icon = icon_path .. "steam.png"
theme.lutris_icon = icon_path .. "lutris.png"
theme.files_icon = icon_path .. "files.png"
theme.manual_icon = icon_path .. "manual.png"
theme.keyboard_icon = icon_path .. "keyboard.png"
theme.appearance_icon = icon_path .. "appearance.png"
theme.editor_icon = icon_path .. "editor.png"
theme.gimp_icon = icon_path .. "gimp.png"
theme.terminal_icon = icon_path .. "terminal.png"
theme.mail_icon = icon_path .. "mail.png"
theme.music_icon = icon_path .. "music.png"
theme.temperature_icon = icon_path .. "temperature.png"
theme.battery_icon = icon_path .. "battery.png"
theme.battery_charging_icon = icon_path .. "battery_charging.png"
theme.cpu_icon = icon_path .. "cpu.png"
theme.compositor_icon = icon_path .. "compositor.png"
theme.sidebar_icon = icon_path .. "sidebar.png"
theme.ram_icon = icon_path .. "ram.png"
theme.screenshot_icon = icon_path .. "screenshot.png"
theme.home_icon = icon_path .. "home.png"

-- Weather icons
theme.cloud_icon = weather_icon_path .. "cloud.png"
theme.dcloud_icon = weather_icon_path .. "dcloud.png"
theme.ncloud_icon = weather_icon_path .. "ncloud.png"
theme.sun_icon = weather_icon_path .. "sun.png"
theme.star_icon = weather_icon_path .. "star.png"
theme.rain_icon = weather_icon_path .. "rain.png"
theme.snow_icon = weather_icon_path .. "snow.png"
theme.mist_icon = weather_icon_path .. "mist.png"
theme.storm_icon = weather_icon_path .. "storm.png"
theme.whatever_icon = weather_icon_path .. "whatever.png"

-- Exit screen icons
theme.exit_icon = icon_path .. "exit.png"
theme.poweroff_icon = icon_path .. "poweroff.png"
theme.reboot_icon = icon_path .. "reboot.png"
theme.suspend_icon = icon_path .. "suspend.png"
theme.lock_icon = icon_path .. "lock.png"
-- theme.hibernate_icon = icon_path .. "hibernate.png"

-- Icon taglist
theme.ntags = 8
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, theme.ntags do
  theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
end

-- Prompt
theme.prompt_fg = accent_color

-- Text Taglist
theme.taglist_font = theme.font .. " 11"
theme.taglist_bg_focus = color0 .. "00"
theme.taglist_fg_focus = color14
theme.taglist_bg_occupied = color0 .. "00"
theme.taglist_fg_occupied = color4
theme.taglist_bg_empty = color0 .. "00"
theme.taglist_fg_empty = color8
theme.taglist_bg_urgent = color0 .. "00"
theme.taglist_fg_urgent = urgent_color
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)
--theme.taglist_item_roundness = 0
theme.taglist_item_roundness = theme.border_radius
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
theme.menu_submenu_icon = icon_path.."submenu.png"
theme.menu_height = dpi(35)
theme.menu_width  = dpi(180)
theme.menu_bg_normal = color0
theme.menu_fg_normal= color7
theme.menu_bg_focus = color8 .. "55"
theme.menu_fg_focus= color7
theme.menu_border_width = 0
theme.menu_border_color = color0

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Titlebar buttons
-- Define the images to load
theme.titlebar_close_button_normal = tip .. "close_normal.svg"
theme.titlebar_close_button_focus  = tip .. "close_focus.svg"
theme.titlebar_minimize_button_normal = tip .. "minimize_normal.svg"
theme.titlebar_minimize_button_focus  = tip .. "minimize_focus.svg"
theme.titlebar_ontop_button_normal_inactive = tip .. "ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = tip .. "ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = tip .. "ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = tip .. "ontop_focus_active.svg"
theme.titlebar_sticky_button_normal_inactive = tip .. "sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = tip .. "sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = tip .. "sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = tip .. "sticky_focus_active.svg"
theme.titlebar_floating_button_normal_inactive = tip .. "floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = tip .. "floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = tip .. "floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = tip .. "floating_focus_active.svg"
theme.titlebar_maximized_button_normal_inactive = tip .. "maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = tip .. "maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = tip .. "maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = tip .. "maximized_focus_active.svg"
-- (hover)
theme.titlebar_close_button_normal_hover = tip .. "close_normal_hover.svg"
theme.titlebar_close_button_focus_hover  = tip .. "close_focus_hover.svg"
theme.titlebar_minimize_button_normal_hover = tip .. "minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover  = tip .. "minimize_focus_hover.svg"
theme.titlebar_ontop_button_normal_inactive_hover = tip .. "ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover  = tip .. "ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover = tip .. "ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover  = tip .. "ontop_focus_active_hover.svg"
theme.titlebar_sticky_button_normal_inactive_hover = tip .. "sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover  = tip .. "sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover = tip .. "sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover  = tip .. "sticky_focus_active_hover.svg"
theme.titlebar_floating_button_normal_inactive_hover = tip .. "floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover  = tip .. "floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover = tip .. "floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover  = tip .. "floating_focus_active_hover.svg"
theme.titlebar_maximized_button_normal_inactive_hover = tip .. "maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = tip .. "maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = tip .. "maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover  = tip .. "maximized_focus_active_hover.svg"

-- You can use your own layout icons like this:
theme.layout_fairh = layout_icon_path .. "fairh.png"
theme.layout_fairv = layout_icon_path .. "fairv.png"
theme.layout_floating  = layout_icon_path .. "floating.png"
theme.layout_magnifier = layout_icon_path .. "magnifier.png"
theme.layout_max = layout_icon_path .. "max.png"
theme.layout_fullscreen = layout_icon_path .. "fullscreen.png"
theme.layout_tilebottom = layout_icon_path .. "tilebottom.png"
theme.layout_tileleft   = layout_icon_path .. "tileleft.png"
theme.layout_tile = layout_icon_path .. "tile.png"
theme.layout_tiletop = layout_icon_path .. "tiletop.png"
theme.layout_spiral  = layout_icon_path .. "spiral.png"
theme.layout_dwindle = layout_icon_path .. "dwindle.png"
theme.layout_cornernw = layout_icon_path .. "cornernw.png"
theme.layout_cornerne = layout_icon_path .. "cornerne.png"
theme.layout_cornersw = layout_icon_path .. "cornersw.png"
theme.layout_cornerse = layout_icon_path .. "cornerse.png"

-- Recolor layout icons
--theme = theme_assets.recolor_layout(theme, color1)

-- Noodle widgets customization --
-- Desktop mode widget variables
-- Symbols     
-- theme.desktop_mode_color_floating = color4
-- theme.desktop_mode_color_tile = color3
-- theme.desktop_mode_color_max = color1
-- theme.desktop_mode_text_floating = "f"
-- theme.desktop_mode_text_tile = "t"
-- theme.desktop_mode_text_max = "m"

-- Minimal tasklist widget variables
theme.minimal_tasklist_visible_clients_color = focused_color
theme.minimal_tasklist_visible_clients_text = "+ "
theme.minimal_tasklist_hidden_clients_color = color8
theme.minimal_tasklist_hidden_clients_text = " - "

-- Spotify song
theme.spotify_song_title_color = color7
theme.spotify_song_artist_color = color7
theme.spotify_song_paused_color = color7 .. "33"

-- Volume bar
theme.volume_bar_active_color = color6
theme.volume_bar_active_background_color = color6 .. "33"
theme.volume_bar_muted_color = color8
theme.volume_bar_muted_background_color = color8 .. "33"

-- Temperature bar
theme.temperature_bar_active_color = color1
theme.temperature_bar_background_color = color1 .. "33"

-- Battery bar
theme.battery_bar_active_color = color5
theme.battery_bar_background_color = color5 .. "33"

-- CPU bar
theme.cpu_bar_active_color = color2
theme.cpu_bar_background_color = color2 .. "33"

-- RAM bar
theme.ram_bar_active_color = color12
theme.ram_bar_background_color = color12 .. "33"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Numix"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
