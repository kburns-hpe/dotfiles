-- Cobalt Theme
require("awful.util")

theme = {}

-- Directories
home            = os.getenv("HOME")
images          = home .. "/.config/awesome/images/"
theme.wallpaper = images .. "wallpaper.png"

fontsize = 8 + (sizemultiplier * 2)

-- Fonts
theme.font              = "Meslo LG M " .. fontsize
theme.tooltip_font      = "Meslo LG S " .. (fontsize + 2)
theme.tasklist_font     = "Meslo LG S " .. fontsize
theme.taglist_font      = "FontAwesome " .. fontsize

-- Color Definitions
theme.colors = {}
theme.colors.background = "#193549"
theme.colors.foreground = "#FFFFFF"
theme.colors.black = "#000000"
theme.colors.red = "#FF0900"
theme.colors.green = "#38DE21"
theme.colors.yellow = "#FFDD00"
theme.colors.blue = "#0088FF"
theme.colors.magenta = "#FF628C"
theme.colors.cyan = "#80FFC2"
theme.colors.white = "#BBBBBB"
theme.colors.brblack = "#555555"
theme.colors.orange = "#FF9D00"
theme.colors.brgreen = "#3BD01D"
theme.colors.bryellow = "#EDC809"
theme.colors.brblue = "#5555FF"
theme.colors.pink = "#FF55FF"
theme.colors.brcyan = "#6AE3FA"
theme.colors.brwhite = "#FFFFFF"

theme.bg_normal = theme.colors.background
theme.bg_focus = theme.colors.white
theme.bg_urgent = theme.bg_normal
theme.bg_minimize   = theme.colors.background
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.colors.white
theme.fg_focus = theme.colors.brblack
theme.fg_urgent = theme.colors.red
theme.fg_minimize   = theme.colors.white

theme.border_width  = 2
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.colors.brblue
theme.border_marked = theme.colors.red

theme.taglist_bg_color = theme.colors.background
theme.taglist_fg_color = theme.colors.white
theme.taglist_bg_focus = theme.colors.background
theme.taglist_fg_focus = theme.colors.orange

theme.tasklist_bg_color = theme.colors.background
theme.tasklist_fg_color = theme.colors.white
theme.tasklist_bg_focus = theme.colors.background
theme.tasklist_fg_focus = theme.colors.orange

theme.tooltip_bg_color = theme.colors.background
theme.tooltip_fg_color = theme.colors.white
theme.tooltip_border_width = 3
theme.tooltip_border_color = theme.colors.brblue

theme.menu_fg_normal = theme.colors.white
theme.menu_bg_normal = theme.colors.background

-- widgets menu
theme.widgets_menu_bg_normal = theme.colors.background
theme.widgets_menu_bg_focus = theme.colors.background

-- Tasklist properties
theme.tasklist_sticky = "[S] "
theme.tasklist_ontop = "[T] "
theme.tasklist_floating = "[F] "
theme.tasklist_maximized_horizontal = "[M] "
theme.tasklist_maximized_vertical = ""
theme.tasklist_disable_icon = true

-- Menus
theme.menu_submenu_icon     =  images .. "menuexpand.png"
theme.menu_width            = 180
theme.menu_border_width     = 2

-- Taglist

-- Icons
theme.tasklist_floating_icon    = images .. "floating.png"
theme.awesome_icon              = images .. "arch-blue.png"

return theme
