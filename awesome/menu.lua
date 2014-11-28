-- Initial enviornment options
local capi =
{
  screen = screen,
  mouse = mouse,
  client = client,
  keygrabber = keygrabber
}

-- alias
sexec		= awful.util.spawn_with_shell

-- Shutdown Menu
function showShutdownMenu(menu, args)
  if not menu then
    menu = {}
  end
  menu.items = mysystemmenu

  local m = awful.menu.new(menu)
  m:show(args)
  return m
end

-- Menu shown when right clicked on tasklist
function showNavMenu(menu, args)
  if not menu then
    menu = {}
  end
  c = capi.client.focus

  local mynav = {
    { "to master", function () c:swap(awful.client.getmaster(1)) end, images .. "tomaster.png" },
    { "maximize", function () c.maximized_horizontal = not c.maximized_horizontal c.maximized_vertical = not c.maximized_vertical end, images .. "maximize.png" },
    { "close", function ()  c:kill() end, images .. "close.png" },
  }
  menu.items = mynav

  local m = awful.menu.new(menu)
  m:show(args)
  return m
end

-- System Menu shown when right clicking on wallpaper
mysystemmenu = {
  { "Shutdown", function () sexec("systemctl poweroff") end},
  { " ", function () awful.menu.hide(instance) end, nil},
  { "Reboot", function () sexec("systemctl restart") end},
  { "Suspend", function () sexec("systemctl suspend") end},
  { " ", function () awful.menu.hide(instance) end, nil},
  { "Lock", function () sexec("xscreensaver-command -lock") end},
}

mymainmenu = awful.menu({ items = {
  { "Restart", awesome.restart },
  { "Quit", awesome.quit },
  { "Exit", mysystemmenu, images .. "arch-blue.png" },
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })
