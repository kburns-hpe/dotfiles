-- Load required modules
naughty = require("naughty")
vicious = require("vicious")
vicious.contrib = require("vicious.contrib")
wibox = require("wibox")

-- bar size
barheight = 18 + (4 * sizemultiplier)

-- alias
sexec		= awful.util.spawn_with_shell

-- systray
mysystray = wibox.widget.systray()

-- wiboxes
mywibox = {}
mywib = {}
mypromptbox = {}
mylayoutbox = {}

-- span shortcuts
spanblue = "<span foreground='#0088ff'>"
spangray = "<span foreground='#bbbbbb'>"
stopspan = "</span>"

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
doingicon = wibox.widget.textbox()
doingicon:set_text("")
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
      doingicon:set_text("")
      doingwidget:set_text("")
    else
      doingicon:set_markup(spanblue .. "" .. stopspan)
      doingwidget:set_text(doing)
    end
  fh:close()
end
)

doingwidgettimer:start()

-- mailbox widget
mymailicon = wibox.widget.textbox()
mymailicon:set_markup(spanblue .. "" .. stopspan)

local mailwidget = wibox.widget.textbox()
vicious.register(mailwidget, vicious.widgets.mdir, "$1", 300, widget.mailbox)

-- File System Widget
myfsicon = wibox.widget.textbox()
myfsicon:set_markup(spanblue .. "" .. stopspan)

local hdwidget = wibox.widget.textbox()
vicious.register(hdwidget, vicious.widgets.fs, "${" .. widget.drive .. " avail_gb}", 60)

-- CPU Widget
mycpuloadicon = wibox.widget.textbox()
mycpuloadicon:set_markup(spanblue .. "" .. stopspan)

local cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")

-- RAM Widget
myramloadicon = wibox.widget.textbox()
myramloadicon:set_markup(spanblue .. "" .. stopspan)

local memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "$1%", 13)        

-- Thermal Widget
local thermalwidget = wibox.widget.textbox()
vicious.register(thermalwidget, vicious.widgets.thermal, " ($1C)", 11, widget.thermalzone)

-- Clock Widget
mycalicon = wibox.widget.textbox()
mycalicon:set_markup(spanblue .. "" .. stopspan)
mytextclock = awful.widget.textclock(widget.clock)
mytextclock.width = space

-- Volume Widget
myvolicon = wibox.widget.textbox()
myvolicon:set_markup(spanblue .. "" .. stopspan)
myvolicon:buttons(awful.util.table.join(
awful.button({ }, 1, function () sexec("pavucontrol", false) end)))

myvol = wibox.widget.textbox()
myvol.width = space
vicious.register(myvol, vicious.contrib.pulse,
function (widget, args)
	if ((args[1] < 1) or (args[2] == "♩")) then
        myvolicon:set_markup(spanblue .. "" .. stopspan)
		return "mute"
	else
        myvolicon:set_markup(spanblue .. "" .. stopspan)
		return args[1] .. "%" 
	end
end, 3, widget.volume)

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
mywifiicon = wibox.widget.textbox()
mywifiicon:set_markup(spanblue .. "" .. stopspan)

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
    fh = assert(io.popen("/usr/bin/ifconfig", "r"))
    vpn = fh:read("*all")
      if string.find(vpn, "tun0") then
        vpnwidget:set_markup('<span color="red">[VPN]</span>')
      else
        vpnwidget:set_text("")
      end
    fh:close()
  end)

vpnwidgettimer:start()

-- Battery Widget
mybaticon = wibox.widget.imagebox()
local batwidget = wibox.widget.textbox()
if (widget.battery == "dual") then
    fh = assert(io.popen(home .. "/.config/awesome/scripts/dualbattery"))
    dualbattery = fh:read("*all")
    batwidget:set_markup(dualbattery)
    fh:close()
    batwidgettimer = timer({ timeout = 59 })
    batwidgettimer:connect_signal("timeout",
    function()
        fh = assert(io.popen(home .. "/.config/awesome/scripts/dualbattery"))
        dualbattery = fh:read("*all")
        batwidget:set_markup(dualbattery)
        fh:close()
    end)

    batwidgettimer:start()
else
    mybaticon:set_image(images .. "bat_full_01.png")
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
    if widget.battype == "power_now" then
        local file = io.open("/sys/class/power_supply/" .. widget.battery .. "/power_now", "r")
        local power = file:read("*n")
        file:close()
        wattavg = (power / 1000000)
    else
        local file = io.open("/sys/class/power_supply/" .. widget.battery .. "/current_now", "r")
        local current = file:read("*n")
        file:close()
        local file = io.open("/sys/class/power_supply/" .. widget.battery .. "/voltage_now", "r")
        local voltage = file:read("*n")
        file:close()
        wattcur = (current / 1000000)
        wattvolt = (voltage / 1000000)
        wattavg = wattcur * wattvolt
    end
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
end

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
  right_layout:add(doingicon)
  right_layout:add(doingwidget)
  if (s == 1) then
    right_layout:add(mysystray)
  end
--  right_layout:add(spacer)
--  right_layout:add(mymailicon)
--  right_layout:add(spacer)
--  right_layout:add(mailwidget)
--  right_layout:add(updateicon)
--  right_layout:add(updatewidget)
  right_layout:add(spacer)
  right_layout:add(mycpuloadicon)
  right_layout:add(spacer)
  right_layout:add(cpuwidget)
  right_layout:add(thermalwidget)
  right_layout:add(spacer)
  right_layout:add(myramloadicon)
  right_layout:add(spacer)
  right_layout:add(memwidget)
  right_layout:add(spacer)
  right_layout:add(myfsicon)
  right_layout:add(spacer)
  right_layout:add(hdwidget)
  right_layout:add(spacer)
--  right_layout:add(mynetupicon)
--  right_layout:add(netupwidget)
--  right_layout:add(mynetdownicon)
--  right_layout:add(netdownwidget)
  right_layout:add(mywifiicon)
  right_layout:add(wifiwidget)
  right_layout:add(vpnwidget)
  right_layout:add(spacer)
  right_layout:add(mybaticon)
  right_layout:add(batwidget)
  right_layout:add(spacer)
  right_layout:add(myvolicon)
  right_layout:add(spacer)
  right_layout:add(myvol)
  right_layout:add(spacer)
  right_layout:add(mycalicon)
  right_layout:add(spacer)
  right_layout:add(mytextclock)

  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_middle(mytasklist[s])
  layout:set_right(right_layout)
  mywibox[s]:set_widget(layout)
end
