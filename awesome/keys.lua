local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local helpers = require("helpers")

local keys = {}

-- Mod keys
superkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

-- {{{ Mouse bindings on desktop
keys.desktopbuttons = gears.table.join(
    awful.button({ }, 1, function ()
        mymainmenu:hide()
        sidebar.visible = false
        naughty.destroy_all_notifications()

        local function double_tap()
          uc = awful.client.urgent.get()
          -- If there is no urgent client, go back to last tag
          if uc == nil then
            awful.tag.history.restore()
          else
            awful.client.urgent.jumpto()
          end
        end
        helpers.single_double_tap(nil, double_tap)
    end),
    awful.button({ }, 3, function () mymainmenu:toggle() end),

    -- Middle button - Toggle sidebar
    awful.button({ }, 2, function ()
        sidebar.visible = not sidebar.visible
    end),

    -- Scrolling - Switch tags
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),

    -- Side buttons - Control volume
    awful.button({ }, 9, function () awful.spawn.with_shell("volume-control.sh up") end),
    awful.button({ }, 8, function () awful.spawn.with_shell("volume-control.sh down") end)

    -- Side buttons - Minimize and restore minimized client
    -- awful.button({ }, 8, function()
    --     if client.focus ~= nil then
    --         client.focus.minimized = true
    --     end
    -- end),
    -- awful.button({ }, 9, function()
    --       local c = awful.client.restore()
    --       -- Focus restored client
    --       if c then
    --           client.focus = c
    --           c:raise()
    --       end
    -- end)
)
-- }}}

-- {{{ Key bindings
keys.globalkeys = gears.table.join(
	-- Switching views {{
	awful.key({ superkey, ctrlkey   }, "Left",   awful.tag.viewprev,
	{description = "view previous", group = "tag"}),
	awful.key({ superkey, ctrlkey   }, "Right",  awful.tag.viewnext,
	{description = "view next", group = "tag"}),
	-- }}

	-- Focus client by direction {{
	awful.key({ superkey }, "Down",
	function()
		awful.client.focus.bydirection("down")
		if client.focus then client.focus:raise() end
	end,
	{description = "focus down", group = "client"}),
	awful.key({ superkey }, "Up",
	function()
		awful.client.focus.bydirection("up")
		if client.focus then client.focus:raise() end
	end,
	{description = "focus up", group = "client"}),
	awful.key({ superkey }, "Left",
	function()
		awful.client.focus.bydirection("left")
		if client.focus then client.focus:raise() end
	end,
	{description = "focus left", group = "client"}),
	awful.key({ superkey }, "Right",
	function()
		awful.client.focus.bydirection("right")
		if client.focus then client.focus:raise() end
	end,
	{description = "focus right", group = "client"}),
	-- }}

	-- Focus client by index (cycle through clients) {{
	awful.key({ superkey }, "j",
	function ()
		awful.client.focus.byidx( 1)
	end,
	{description = "focus next by index", group = "client"}
	),
	awful.key({ superkey }, "k",
	function ()
		awful.client.focus.byidx(-1)
	end,
	{description = "focus previous by index", group = "client"}
	),
	-- }}

	-- Main menu {{
	awful.key({ superkey }, "F10", function () mymainmenu:show() end,
	{description = "show main menu", group = "awesome"}),
	-- }}

	-- Logout, Shutdown, Restart, Suspend, Lock {{
	awful.key({ superkey }, "Escape",
	function ()
		exit_screen_show()
	end,
	{description = "exit", group = "awesome"}),
	-- }}

	-- Layout manipulation
	awful.key({ superkey, shiftkey }, "Down", function ()
		local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
		local c = client.focus
		-- Floating: move client to edge
		if c ~= nil and (current_layout == "floating" or c.floating) then
			helpers.move_to_edge(c, "down")
		else
			awful.client.swap.bydirection("down", c, nil)
		end
	end,
	{description = "swap with direction down", group = "client"}),
	awful.key({ superkey, shiftkey }, "Up", function ()
		local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
		local c = client.focus
		-- Floating: move client to edge
		if c ~= nil and (current_layout == "floating" or c.floating) then
			helpers.move_to_edge(c, "up")
		else
			awful.client.swap.bydirection("up", c, nil)
		end
	end,
	{description = "swap with direction up", group = "client"}),
	-- No need for these (single screen setup)
	--awful.key({ superkey, ctrlkey }, "j", function () awful.screen.focus_relative( 1) end,
	--{description = "focus the next screen", group = "screen"}),
	--awful.key({ superkey, ctrlkey }, "k", function () awful.screen.focus_relative(-1) end,
	--{description = "focus the previous screen", group = "screen"}),
	-- }}

	-- Urgent Clients {{
	awful.key({ superkey }, "u",
	function ()
		uc = awful.client.urgent.get()
		if uc ~= nil then
			awful.client.urgent.jumpto()
		end
	end,
	{description = "jump to urgent client", group = "client"}),
	-- }}
	
	-- Switching Clients {{
	awful.key({ altkey }, "Tab",
	function ()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end,
	{description = "go back", group = "client"}),
	-- }}
	
	-- Reload awesome {{
	awful.key({ superkey, shiftkey }, "r", awesome.restart,
	{description = "reload awesome", group = "awesome"}),
	-- }}

	-- Master Width Factor {{ Not Relevant
	-- awful.key({ superkey, ctrlkey }, "minus",     function ()
	-- 	local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
	-- 	local c = client.focus
	-- 	-- Floating: resize client
	-- 	if current_layout == "floating" or (c ~= nil and c.floating == true) then
	-- 		c:relative_move(  0,  0, -20, 0)
	-- 	else
	-- 		awful.tag.incmwfact(-0.05)
	-- 	end
	-- end,
	-- {description = "decrease master width factor", group = "layout"}),
	-- awful.key({ superkey, ctrlkey }, "equal",     function ()
	-- 	local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
	-- 	local c = client.focus
	-- 	-- Floating: resize client
	-- 	if current_layout == "floating" or (c ~= nil and c.floating == true) then
	-- 		c:relative_move(  0,  0,  20, 0)
	-- 	else
	-- 		awful.tag.incmwfact( 0.05)
	-- 	end
	-- end,
	-- {description = "increase master width factor", group = "layout"}),
	-- }}

	-- Swapping client positions {{
	awful.key({ superkey, shiftkey }, "Left",
	function ()
		local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
		local c = client.focus
		-- Floating: move client to edge
		if c ~= nil and (current_layout == "floating" or c.floating) then
			--c:relative_move( -40,  0,   0,   0)
			helpers.move_to_edge(c, "left")
		else
			awful.client.swap.bydirection("left", c, nil)
		end
	end,
	{description = "swap with direction left", group = "client"}),
	awful.key({ superkey, shiftkey }, "Right",
	function ()
		local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
		local c = client.focus
		-- Floating: move client to edge
		if c ~= nil and (current_layout == "floating" or c.floating) then
			--c:relative_move(  40,  0,   0,   0)
			helpers.move_to_edge(c, "right")
		else
			awful.client.swap.bydirection("right", c, nil)
		end
	end,
	{description = "swap with direction right", group = "client"}),
	-- }}
	
	-- What are these? {{
	awful.key({ superkey }, "h",   
	function () 
		awful.tag.incnmaster( 1, nil, true) 
	end,
	{description = "increase the number of master clients", group = "layout"}),
	awful.key({ superkey }, "l",   
	function () 
		awful.tag.incnmaster(-1, nil, true) 
	end,
	{description = "decrease the number of master clients", group = "layout"}),
	awful.key({ superkey, shiftkey, ctrlkey }, "h",     function ()
		local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
		local c = client.focus
		-- Floating: move client
		if c ~= nil and (current_layout == "floating" or c.floating) then
			c:relative_move( -20,  0,  0,   0)
		else
			awful.tag.incncol( 1, nil, true)
		end
	end,
	{description = "increase the number of columns", group = "layout"}),
	awful.key({ superkey, shiftkey, ctrlkey }, "l",     function ()
		local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
		local c = client.focus
		-- Floating: move client
		if c ~= nil and (current_layout == "floating" or c.floating) then
			c:relative_move(  20,  0,  0,   0)
		else
			awful.tag.incncol(-1, nil, true)
		end
	end),
	awful.key({ superkey }, "space", function () awful.layout.inc( 1)                end,
	{description = "select next", group = "layout"}),
	awful.key({ superkey, shiftkey   }, "space", function () awful.layout.inc(-1)                end,
	{description = "select previous", group = "layout"}),
	--}}

	-- Minimized Clients {{
	awful.key({ superkey, shiftkey }, "n",
	function ()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			client.focus = c
			c:raise()
		end
	end,
	{description = "restore minimized", group = "client"}),
	-- }}

	-- Useful keyboard shortcuts {{
	-- Dismiss notifications
	awful.key( { ctrlkey }, "space", function()
		naughty.destroy_all_notifications()
	end,
	{description = "dismiss notification", group = "notifications"}),
	-- Volume Control {
	awful.key( { }, "XF86AudioMute", function()
		awful.spawn.with_shell("volume mute")
	end,
	{description = "(un)mute volume", group = "volume"}),
	awful.key( { }, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("volume set -1")
	end,
	{description = "lower volume", group = "volume"}),
	awful.key( { }, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("volume set +1")
	end,
	{description = "raise volume", group = "volume"}),
	-- }
	-- Brightness Control {
	awful.key( { }, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("light -A 5")
	end,
	{description = "increase brightness", group = "brightness"}),
	awful.key( { }, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("light -U 5")
	end,
	{description = "decrease brighness", group = "brightness"}),
	-- }
	-- Screenshots {
	awful.key( { }, "Print", function() awful.spawn.with_shell("gnome-screenshot -a -f ~/downloads/screenshot.png") end,
	{description = "select area to capture screenshot", group = "screenshots"}),
	awful.key( { superkey }, "Print", function() awful.spawn.with_shell("gnome-screenshot -w -f ~/downloads/screenshot.png") end,
	{description = "capture whole screen", group = "screenshots"}),
	-- TODO: Add capture to clipboard
	-- }
	
	-- Toggle tray visibility
	awful.key({ superkey }, "=", function ()
		awful.screen.focused().traybox.visible = not awful.screen.focused().traybox.visible
	end,
	{description = "toggle tray visibility", group = "awesome"}),

	-- TODO: Fix This
	-- Media keys {
	--awful.key({ superkey }, "period", function() awful.spawn.with_shell("mpc next") end,
	--{description = "next song", group = "media"}),
	--awful.key({ superkey }, "comma", function() awful.spawn.with_shell("mpc prev") end,
	--{description = "previous song", group = "media"}),
	--awful.key({ superkey }, "space", function() awful.spawn.with_shell("mpc toggle") end,
	--{description = "toggle pause/play", group = "media"}),
	--awful.key({ superkey, shiftkey }, "period", function() awful.spawn.with_shell("mpvc next") end,
	--{description = "mpv next song", group = "media"}),
	--awful.key({ superkey, shiftkey }, "comma", function() awful.spawn.with_shell("mpvc prev") end,
	--{description = "mpv previous song", group = "media"}),
	--awful.key({ superkey, shiftkey}, "space", function() awful.spawn.with_shell("mpvc toggle") end,
	--{description = "mpv toggle pause/play", group = "media"}),
	--awful.key({ superkey }, "F8", function() awful.spawn.with_shell("mpvc quit") end,
	--{description = "mpv quit", group = "media"}),
	-- }

	-- TODO: Fix This
	--awful.key({ superkey }, "q", function()
		--if client.focus ~= nil and client.focus.class == "scratchpad" then
			--client.focus.minimized = true
			--return
		--end
		--local matcher = function (c)
			--return awful.rules.match(c, {class = 'scratchpad'})
		--end
		--awful.client.run_or_raise( "scratchpad" , matcher)
	--end,
	--{description = "scratchpad", group = "launcher"}),
	
	-- Layout Management {{
	-- Set max layout
	awful.key({ superkey }, "w", function()
		awful.layout.set(awful.layout.suit.max)
	end,
	{description = "set max layout", group = "tag"}),
	-- Set tiled layout
	awful.key({ superkey }, "e", function()
		awful.layout.set(awful.layout.suit.spiral.dwindle)
	end,
	{description = "set dwindle layout", group = "tag"}),
	-- Set floating layout
	awful.key({ superkey }, "s", function()
		awful.layout.set(awful.layout.suit.fair)
	end,
	{description = "set fair layout", group = "tag"}),
	awful.key({ superkey }, "a", function()
		awful.layout.set(awful.layout.suit.floating)
	end,
	{description = "set floating layout", group = "tag"}),
	-- }}

	-- Program shortcuts {{
	awful.key({ superkey }, "t", function () awful.spawn(terminal) end,
	{description = "open a terminal", group = "launcher"}),
	-- Spawn floating terminal
	awful.key({ superkey, shiftkey }, "t", function()
		awful.spawn(terminal, {floating = true})
	end,
	{description = "spawn floating terminal", group = "launcher"}),
	-- Spawn rofi with combi mode
	awful.key({ superkey }, "Return",
	function()
		awful.spawn.with_shell("rofi -show combi -theme fatmenu")
	end,
	{description = "rofi launcher", group = "launcher"}),
	-- Run or raise or minimize calcurse
	awful.key({ superkey }, "F1", function() awful.spawn(terminal .. " -e calcurse") end,
	{description = "calcurse", group = "launcher"}),
	-- Spawn ranger in a terminal
	awful.key({ superkey }, "F2", function() awful.spawn(terminal .. " -e ranger") end,
	{description = "ranger", group = "launcher"}),
	-- Spawn cava in a terminal
	awful.key({ superkey, shiftkey }, "F3", function() awful.spawn(terminal .. " -e cava") end,
	{description = "cava", group = "launcher"}),
	-- Open new gvim client frame
	awful.key({ superkey }, "g", function() awful.spawn("gvim") end,
	{description = "gvim", group = "launcher"}),
	-- Spawn htop in a terminal
	awful.key({ superkey }, "p", function()
		if client.focus ~= nil and client.focus.class == "htop" then
			client.focus.minimized = true
			return
		end
		local matcher = function (c)
			return awful.rules.match(c, {class = 'htop'})
		end
		awful.client.run_or_raise( terminal .. " --class htop -e htop", matcher)
	end,
	{description = "htop", group = "launcher"}),
    -- }}

	-- Toggling bars {{
	-- Toggle sidebar
	awful.key({ superkey }, "grave", function() sidebar.visible = not sidebar.visible end,
	{description = "show or hide sidebar", group = "awesome"}),
	-- Toggle wibar
	awful.key({ superkey, shiftkey }, "b",
	function()
		local s = awful.screen.focused()
		s.mywibox.visible = not s.mywibox.visible
		if beautiful.wibar_detached then
			s.useless_wibar.visible = not s.useless_wibar.visible
		end
	end,
	{description = "show or hide wibar", group = "awesome"})
	-- }}
)

keys.clientkeys = gears.table.join(
    -- Move floating client (relative)
    awful.key({ superkey, shiftkey   }, "Down",   function (c) c:relative_move(  0,  40,   0,   0) end),
    awful.key({ superkey, shiftkey   }, "Up",     function (c) c:relative_move(  0, -40,   0,   0) end),
    awful.key({ superkey, shiftkey   }, "Left",   function (c) c:relative_move(-40,   0,   0,   0) end),
    awful.key({ superkey, shiftkey   }, "Right",  function (c) c:relative_move( 40,   0,   0,   0) end),
    -- Center client
    awful.key({ superkey }, "c",  function (c)
        awful.placement.centered(c,{honor_workarea=true})
        --awful.placement.centered(c,nil)
    end),
    -- Resize client
    awful.key({ superkey, ctrlkey }, "Down",     function (c)
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        if current_layout == "floating" or c.floating == true then
          c:relative_move(  0,  0,  0, 20)
        else
          awful.client.incwfact(0.05)
        end
    end),
    awful.key({ superkey, ctrlkey }, "Up",     function (c)
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        if current_layout == "floating" or c.floating == true then
            c:relative_move(  0,  0,  0, -20)
        else
            awful.client.incwfact(-0.05)
        end
    end),
    awful.key({ superkey, shiftkey, ctrlkey }, "Down", function (c)
        -- Relative move
        c:relative_move(0,  20, 0, 0)
    end),
    awful.key({ superkey, shiftkey, ctrlkey }, "Up", function (c)
        -- Relative move
        c:relative_move(0, -20, 0, 0)
    end),
    -- Toggle titlebar (for focused client only)
    awful.key({ superkey }, "d",
        function (c)
            -- Don't toggle if titlebars are used as borders
            if not beautiful.titlebars_imitate_borders then
                awful.titlebar.toggle(c, beautiful.titlebar_position)
            end
        end,
        {description = "toggle titlebar", group = "client"}),
    -- Toggle titlebar (for all visible clients in selected tag)
    awful.key({ superkey, shiftkey }, "d",
        function (c)
            --local s = awful.screen.focused()
            local clients = awful.screen.focused().clients
            for _, c in pairs(clients) do
                -- Don't toggle if titlebars are used as borders
                if not beautiful.titlebars_imitate_borders then
                    awful.titlebar.toggle(c, beautiful.titlebar_position)
                end
            end
        end,
        {description = "toggle titlebar", group = "client"}),
    -- Toggle fullscreen
    awful.key({ superkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    -- Resize and set floating - Predetermined size according to screen
    -- F for focused view
    awful.key({ superkey, ctrlkey  }, "f",
        function (c)
          -- c.width = 950
          -- c.height = 600
            c.floating = true
            c.width = screen_width * 0.7
            c.height = screen_height * 0.75
            awful.placement.centered(c,{honor_workarea=true})
            c:raise()
        end,
        {description = "focus mode", group = "client"}),
    -- V for vertical view
    awful.key({ superkey, ctrlkey  }, "v",
      function (c)
        c.floating = true
        c.width = screen_width * 0.45
        c.height = screen_height * 0.85
        awful.placement.centered(c,{honor_workarea=true})
        c:raise()
      end,
      {description = "focus mode", group = "client"}),
    -- T for tiny window
    awful.key({ superkey, ctrlkey  }, "t",
        function (c)
            -- c.width = 400
            -- c.height = 260
            c.floating = true
            c.width = screen_width * 0.3
            c.height = screen_height * 0.35
            awful.placement.centered(c,{honor_workarea=true})
            c:raise()
        end,
        {description = "tiny mode", group = "client"}),
    -- N for normal window
    awful.key({ superkey, ctrlkey  }, "n",
        function (c)
            c.floating = true
            c.width = screen_width * 0.45
            c.height = screen_height * 0.5
            awful.placement.centered(c,{honor_workarea=true})
            c:raise()
        end,
        {description = "normal mode", group = "client"}),
    awful.key({ superkey }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    -- Toggle floating
	awful.key({ superkey, ctrlkey }, "space",
	function(c)
		local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
		if current_layout ~= "floating" then
			awful.client.floating.toggle()
		end
		c:raise()
	end,
	{description = "toggle floating", group = "client"}),
    awful.key({ superkey, ctrlkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ superkey }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    -- P for pin: keep on top OR sticky
    -- On top
    awful.key({ superkey, shiftkey }, "o",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    -- Sticky
    awful.key({ superkey, shiftkey }, "s",      function (c) c.sticky = not c.sticky            end,
              {description = "toggle sticky", group = "client"}),
    -- Minimize
    awful.key({ superkey }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ superkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}),
    awful.key({ superkey, ctrlkey }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ superkey, shiftkey   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = beautiful.ntags
for i = 1, ntags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ superkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        local current_tag = screen.selected_tag
                        -- Tag back and forth:
                        -- If you try to focus the same tag you are at,
                        -- go back to the previous tag.
                        -- Useful for quick switching after for example
                        -- checking an incoming chat message at tag 2
                        -- and coming back to your work at tag 1
                        if tag then
                           if tag == current_tag then
                               awful.tag.history.restore()
                           else
                               tag:view_only()
                           end
                        end
                        -- Simple tag view
                        --if tag then
                           --tag:view_only()
                        --end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ superkey, ctrlkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag
        awful.key({ superkey, shiftkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
        {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

for i = 1, ntags / 2 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ superkey, altkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[ntags / 2 + i]
                        local current_tag = screen.selected_tag
                        -- Tag back and forth:
                        -- If you try to focus the same tag you are at,
                        -- go back to the previous tag.
                        -- Useful for quick switching after for example
                        -- checking an incoming chat message at tag 2
                        -- and coming back to your work at tag 1
                        if tag then
                           if tag == current_tag then
                               awful.tag.history.restore()
                           else
                               tag:view_only()
                           end
                        end
                        -- Simple tag view
                        --if tag then
                           --tag:view_only()
                        --end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ superkey, ctrlkey, altkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[ntags / 2 + i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag
        awful.key({ superkey, shiftkey, altkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[ntags / 2 + i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
        {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ superkey, ctrlkey, shiftkey, altkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[ntags / 2 + i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ superkey }, 1, awful.mouse.client.move),
    awful.button({ superkey }, 2, function (c) c:kill() end),
    awful.button({ superkey }, 3, function(c)
        awful.mouse.resize(c, nil, {jump_to_corner=true})
    end)
)
-- }}}

-- Set keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
