-- Global Key Bindings
globalkeys = awful.util.table.join(
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
  awful.key({ modkey,           }, "j",
  function ()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey,           }, "k",
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) 
  end),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey,           }, "Tab",
  function ()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end),

  -- Custom Keys
  awful.key({}, "XF86Display", function () awful.util.spawn_with_shell(home .. "/bin/dock.sh") end),
  awful.key({}, "XF86AudioMute", function () awful.util.spawn_with_shell("pactl set-sink-mute alsa_output.pci-0000_00_1b.0.analog-stereo toggle") end),
  awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell("amixer set Master 2%+") end),
  awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell("amixer set Master 2%-") end),
  awful.key({}, "XF86MonBrightnessUp", function () awful.util.spawn_with_shell("xbacklight -inc 10") end),
  awful.key({}, "XF86MonBrightnessDown", function () awful.util.spawn_with_shell("xbacklight -dec 10") end),
  awful.key({}, "XF86ScreenSaver", function () awful.util.spawn_with_shell("xautolock -locknow") end),

  -- Change Monitors
  awful.key({ hyper, }, "F7", function () awful.util.spawn(home .. "/bin/dock.sh")  end),

  -- Fix Copy/paste for windows
  awful.key({ hyper, }, "c", function () awful.util.spawn("xsel -p | dos2unix | xsel -i -p")  end),

  -- Program Launches
  awful.key({ modkey, }, "r", function () awful.util.spawn("rofi -show run")  end),
  awful.key({ modkey, }, "d", function () awful.util.spawn(home .. "/bin/rofi-doing.sh")  end),
  awful.key({ modkey, }, "x", function () awful.util.spawn(home .. "/bin/rofi-task.sh")  end),
  awful.key({ hyper, }, "l", function () awful.util.spawn("xautolock -locknow") end),
  awful.key({ hyper, }, "a", function () awful.util.spawn("pavucontrol")  end),
  awful.key({ modkey, }, "a", function () awful.util.spawn("anamnesis -b")  end),
  awful.key({ hyper, }, "b", function () awful.util.spawn(browser)  end),
  awful.key({ hyper, }, "n", function () awful.util.spawn("termite -name nvim -e nvim")  end),
  awful.key({ hyper, }, "s", function () awful.util.spawn("termite -name social -e social")  end),
  awful.key({ hyper, }, "v", function () awful.util.spawn("vmplayer")  end),
  awful.key({ hyper, }, "F12", function () awful.util.spawn("systemctl poweroff")  end),
awful.key({ }, "Print", function () awful.util.spawn_with_shell("maim " .. home .. "/screenshots/$(date +%F-%T).png") end),
awful.key({ altkey, }, "Print", function () awful.util.spawn_with_shell("maim -s " .. home .. "/screenshots/$(date +%F-%T).png") end),
awful.key({ modkey, }, "Print", function () awful.util.spawn_with_shell("maim -i $(xdotool getactivewindow) " .. home .. "/screenshots/$(date +%F-%T).png") end),

  -- Standard program
  awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
  awful.key({ hyper,            }, "Return", function () awful.util.spawn("termite") end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit),

  -- Navigation Keys
  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.02)    end),
  awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.02)    end),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
  awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

  -- Mark doing project as done
  awful.key({ hyper }, "d",
    function ()
      awful.util.spawn(home .. "/bin/doing done")
    end),
    
  -- Add to bugs me list
  awful.key({ modkey }, "b",
    function ()
      awful.prompt.run({ prompt = "BugsMe: ", text="" },
      mypromptbox[mouse.screen].widget,
      function(input)
        awful.util.spawn("bugsme " .. input)
      end)
    end)
)

-- Client Management Keys
clientkeys = awful.util.table.join(
  awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
  awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
  awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
  awful.key({ modkey,           }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
    end)
)

-- Count Tags, up to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
for i = 1, keynumber do
  globalkeys = awful.util.table.join(globalkeys,
  awful.key({ modkey }, "#" .. i + 9,
    function ()
      local screen = mouse.screen
      if tags[screen][i] then
        awful.tag.viewonly(tags[screen][i])
      end
    end),
  awful.key({ modkey, "Control" }, "#" .. i + 9,
    function ()
      local screen = mouse.screen
      if tags[screen][i] then
        awful.tag.viewtoggle(tags[screen][i])
      end
    end),
  awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
      if client.focus and tags[client.focus.screen][i] then
        awful.client.movetotag(tags[client.focus.screen][i])
      end
    end),
  awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    function ()
      if client.focus and tags[client.focus.screen][i] then
        awful.client.toggletag(tags[client.focus.screen][i])
      end
    end))
end

-- mouse binds
root.buttons(awful.util.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
