-- Solarized Theme
require("awful.util")

theme = {}

-- Directories
home            = os.getenv("HOME")
images          = home .. "/.config/awesome/images/"
theme.wallpaper = images .. "wallpaper.png"


-- Fonts
fontsize = 8 + (sizemultiplier * 2)
theme.font              = "Meslo LG M " .. fontsize
theme.tooltip_font      = "Meslo LG S " .. (fontsize + 2)
theme.tasklist_font     = "Meslo LG S " .. fontsize
theme.taglist_font      = "FontAwesome " .. fontsize

-- Color Definitions
theme.colors = {}
theme.colors.base03 = "#002b36"
theme.colors.base02 = "#073642"
theme.colors.base01 = "#586e75"
theme.colors.base00 = "#657b83"
theme.colors.base0 = "#839496"
theme.colors.base1 = "#93a1a1"
theme.colors.base2 = "#eee8d5"
theme.colors.base3 = "#fdf6e3"
theme.colors.yellow = "#b58900"
theme.colors.orange = "#cb4b16"
theme.colors.red = "#dc322f"
theme.colors.magenta = "#d33682"
theme.colors.violet = "#6c71c4"
theme.colors.blue = "#268bd2"
theme.colors.cyan = "#2aa198"
theme.colors.green = "#859900"

theme.bg_normal = theme.colors.base03
theme.bg_focus = theme.colors.base02
theme.bg_urgent = theme.bg_normal
theme.bg_minimize   = theme.colors.base03
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.colors.base0
theme.fg_focus = theme.colors.base0
theme.fg_urgent = theme.colors.red
theme.fg_minimize   = theme.colors.base0

theme.border_width  = 3
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.colors.red

theme.taglist_bg_color = theme.colors.base03
theme.taglist_fg_color = theme.colors.base0
theme.taglist_bg_focus = theme.colors.base02
theme.taglist_fg_focus = theme.colors.base0

theme.tasklist_bg_color = theme.colors.base03
theme.tasklist_fg_color = theme.colors.base0
theme.tasklist_bg_focus = theme.colors.base02
theme.tasklist_fg_focus = theme.colors.base0

theme.tooltip_bg_color = theme.colors.base03
theme.tooltip_fg_color = theme.colors.base0
theme.tooltip_border_width = 3
theme.tooltip_border_color = theme.colors.base02

theme.menu_fg_normal = theme.colors.base0
theme.menu_bg_normal = theme.colors.base03

-- widgets menu
theme.widgets_menu_bg_normal = theme.colors.base03
theme.widgets_menu_bg_focus = theme.colors.base03

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
