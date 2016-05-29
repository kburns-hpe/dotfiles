-- rc.lua originally by intrntbrn
-- www.github.com/intrntbrn
-- modified by soleblaze
-- www.github.com/soleblaze

-- Initial Options
require("config")

-- Load Required Modules
awful = require("awful")
awful.autofocus = require("awful.autofocus")
awful.rules = require("awful.rules")
gears = require("gears")
require("eminent")

-- Generate a multipler based on dpi > 96
-- Every 25% increase in dpi adds 1 to the multipler
f = assert (io.popen("xrdb -query"))
xrdb = f:read("*all")
xftdpi = string.match(xrdb, "Xft.dpi:%s+%d+")
dpi = string.match(xftdpi, "%d+")
sizemultiplier = (dpi - 96)/24

-- theme
beautiful = require("beautiful")
beautiful.init(theme)

-- set wallpaper
for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

-- Configuration files
require("menu")
require("tags")
require("widgets")
require("bindings")
require("rules")
require("notification")
require("signals")
