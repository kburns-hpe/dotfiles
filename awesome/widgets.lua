-- Load required modules
naughty = require("naughty")
vicious = require("vicious")
wibox = require("wibox")

-- alias
sexec		= awful.util.spawn_with_shell

-- systray
mysystray = wibox.widget.systray()

-- wiboxes
mywibox = {}
mywib = {}
mypromptbox = {}
mylayoutbox = {}

-- prompt
myprompt	= "Run:"

-- Required functions for widgets
function round(num, idp)
  if (num ~= nil) then
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
  else
    return 0
  end
end

-- spacer
spacer = wibox.widget.textbox()
spacer:set_text(" ")

-- Doing Widget (http://brettterpstra.com/projects/doing/)
doingicon = wibox.widget.imagebox()
doingicon:set_image()
doingicon_t = awful.tooltip({ objects = { doingicon },})
doingicon:connect_signal("mouse::enter", function()
  doinginfo = awful.util.pread(home .. "/bin/doing view done | head")
  doinginfo = doinginfo:match( "(.-)%s*$")
  doingicon_t:set_text(doinginfo)
end)

doingwidget = wibox.widget.textbox()
doingwidget:set_text("")
doingwidgettimer = timer({ timeout = 9 })
doingwidgettimer:connect_signal("timeout",
 function()
    fh = assert(io.popen(home .. "/bin/doing last", "r"))
    doing = fh:read("*all")
    if string.find(doing, "@done") then
      doingicon:set_image()
      doingwidget:set_text("")
    else
      doingicon:set_image(images .. "info_01.png")
      doingwidget:set_text(doing)
    end
  fh:close()
end
)

doingwidgettimer:start()


-- File System Widget
myfsicon = wibox.widget.imagebox()
myfsicon:set_image(images .. "diskette.png")

myfs_ssd_t = awful.tooltip({ objects = { myfsicon },})
myfsicon:connect_signal("mouse::enter", function()
  dfinfo =  awful.util.pread(widget.dfscript)
  dfinfo = dfinfo:match( "(.-)%s*$")
  myfs_ssd_t:set_text(dfinfo)
end)

local hdwidget = wibox.widget.textbox()
vicious.register(hdwidget, vicious.widgets.fs, "${" .. widget.drive .. " avail_gb}", 60)

-- CPU Widget
mycpuloadicon = wibox.widget.imagebox()
mycpuloadicon:set_image(images .. "cpu.png")	

local cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")

-- RAM Widget
myramloadicon = wibox.widget.imagebox()
myramloadicon:set_image(images .. "ram.png") 

local memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "$1%", 13)        

-- Thermal Widget
local thermalwidget = wibox.widget.textbox()
vicious.register(thermalwidget, vicious.widgets.thermal, " ($1C)", 11, widget.thermalzone)

-- Clock Widget
mycalicon = wibox.widget.imagebox()
mycalicon:set_image(images .. "clock.png")
mytextclock = awful.widget.textclock(widget.clock)
mytextclock.width = space

-- Volume Widget
myvolicon = wibox.widget.imagebox()
myvolicon:set_image(images .. "spkr_01.png")
myvolicon:buttons(awful.util.table.join(
awful.button({ }, 1, function () sexec("pavucontrol", false) end)))

myvol = wibox.widget.textbox()
myvol.width = space
vicious.register(myvol, vicious.widgets.volume,
function (widget, args)
	if ((args[1] < 1) or (args[2] == "♩")) then
		myvolicon:set_image(images .. "spkr_02.png")
		return "mute"
	else
		myvolicon:set_image(images .. "spkr_01.png")
		return args[1] .. "%" 
	end
end, 2, widget.volume)

-- Network Widget
mynetupicon = wibox.widget.imagebox()
mynetupicon:set_image(images .. "net_up_03.png")
mynetdownicon = wibox.widget.imagebox()
mynetdownicon:set_image(images .. "net_down_03.png")

local netupwidget = wibox.widget.textbox()
vicious.register(netupwidget, vicious.widgets.net, "${" .. widget.network .. " up_kb}", 5)

local netdownwidget = wibox.widget.textbox()
vicious.register(netdownwidget, vicious.widgets.net, "${" .. widget.network .. " down_kb} ", 5)

-- Wifi Widget
mywifiicon = wibox.widget.imagebox()
mywifiicon:set_image(images .. "wifi_03.png")

local wifiwidget = wibox.widget.textbox()
vicious.register(wifiwidget, vicious.widgets.wifi, " ${ssid} (${linp}%)", 5, widget.wifi)

-- Package Manager Update Widget
updateicon = wibox.widget.imagebox()
updateicon:set_image(images .. "pacman.png")
local updatingwidget = wibox.widget.textbox()
updatewidget = wibox.layout.margin(updatingwidget)
vicious.register(updatingwidget, vicious.widgets.pkg, 
  function(widget,args) 
    if (args[1]==0) then
      updateicon:set_image()
      updatewidget:set_widget(nil)
    else
      updateicon:set_image(images .. "pacman.png")
      updatewidget:set_widget(updatingwidget)
    end
    return args[1] 
  end, 300, widget.distro)

-- VPN Checking widget
local vpnwidget = wibox.widget.textbox()
vpnwidget = wibox.widget.textbox()
vpnwidget:set_text("")
vpnwidgettimer = timer({ timeout = 7 })
vpnwidgettimer:connect_signal("timeout",
 function()
    fh = assert(io.popen("/usr/bin/ifconfig tun0", "r"))
    vpn = fh:read("*all")
      if string.find(vpn, "UP") then
        vpnwidget:set_markup('<span color="red">[VPN]</span>')
      else
        vpnwidget:set_text("")
      end
    fh:close()
  end)

vpnwidgettimer:start()

-- Battery Widget
mybaticon = wibox.widget.imagebox()
mybaticon:set_image(images .. "bat_full_01.png")

local batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, "$3 ($2%)", 60, widget.battery)

function shdown()
  sexec("systemctl suspend")
end

function batstate()
  local fileee = io.open("/sys/class/power_supply/" .. widget.battery .. "/status", "r")
  local batstate = fileee:read("*line")
  if ((batstate == 'Discharging') or (batstate == 'Charging')) then
    return batstate
  else
    return "Fully Charged"
  end
end

function watt()
  if (batstate() == 'Discharging') then
    local file = io.open("/sys/class/power_supply/" .. widget.battery .. "/power_now", "r")
    local avg = file:read("*n")
    file:close()
    wattavg = (avg / 1000000)
    return round(wattavg, 2) .. " W"
  else
    return "n/a"
  end
end

mybat_t = awful.tooltip({ objects = { mybaticon },})
mybaticon:connect_signal("mouse::enter", function()
  mybat_t:set_text(
  "Usage: " .. watt()
  ) end)

  mybat = wibox.widget.textbox()
  mybat.width = space
  vicious.register(mybat, vicious.widgets.bat,
  function (widget, args)
    batnofiy = nil
    -- Critcal Battery
    if (args[2] < 5 and batstate() == 'Discharging') then
      naughty.notify({
        text = "hybernating to disk now",
        title = "Critical Battery",
        position = "top_right",
        timeout = 30,
        fg=black,
        bg=red,
        ontop = true,
        screen = mouse.screen,
        run = function () sexec("systemctl suspend") end
      })
  	  shdown()
	  mybaticon:set_image(images .. "bat_empty_01.png")
	  return "<span font_desc='" .. fontwidget .."'>" .. args[2] .. "%" .. "</span>"
    -- Low Battery
    elseif (args[2] < 10 and batstate() == 'Discharging') then
naughty.notify({
      text = "charge now",
      title = "Low Battery",
      position = "top_right",
      timeout = 1,
      fg=white,
      bg=blue,
      screen = mouse.screen,
      ontop = true,
    })
    mybaticon:set_image(images .. "bat_empty_01.png")
    return "<span font_desc='" .. fontwidget .."'>" .. args[2] .. "%" .. "</span>"
    -- Normal Battery
    elseif (batstate() == 'Discharging') then
      mybaticon:set_image(images .."bat_full_01.png")
      return "<span font_desc='" .. fontwidget .."'>" .. args[2] .. "%" .. "</span>"
    -- Charging Battery
    else
      mybaticon:set_image(images .. "ac_01.png")
      return "<span font_desc='" .. fontwidget .."'>" .. args[2] .. "%" .. "</span>"
    end
  end, 61, widget.battery)

-- Create bar
for s = 1, screen.count() do
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt({ prompt = myprompt })
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
  awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
  awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
		
  mywibox[s] = awful.wibox({ position = "top", screen = s, height = barheight})

  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(mytaglist[s])
  left_layout:add(mypromptbox[s])
  local right_layout = wibox.layout.fixed.horizontal()
  if (s == 1) then
    right_layout:add(mysystray)
  end
  right_layout:add(doingicon)
  right_layout:add(doingwidget)
--  right_layout:add(updateicon)
--  right_layout:add(updatewidget)
  right_layout:add(mycpuloadicon)
  right_layout:add(cpuwidget)
  right_layout:add(thermalwidget)
  right_layout:add(myramloadicon)
  right_layout:add(memwidget)
  right_layout:add(myfsicon)
  right_layout:add(hdwidget)
--  right_layout:add(mynetupicon)
--  right_layout:add(netupwidget)
--  right_layout:add(mynetdownicon)
--  right_layout:add(netdownwidget)
  right_layout:add(mywifiicon)
  right_layout:add(wifiwidget)
  right_layout:add(vpnwidget)
  right_layout:add(mybaticon)
  right_layout:add(batwidget)
  right_layout:add(myvolicon)
  right_layout:add(myvol)
  right_layout:add(mycalicon)
  right_layout:add(mytextclock)

  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_middle(mytasklist[s])
  layout:set_right(right_layout)
  mywibox[s]:set_widget(layout)
end
