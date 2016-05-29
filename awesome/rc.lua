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

-- theme
beautiful = require("beautiful")
beautiful.init(theme)
barheight = 24

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
