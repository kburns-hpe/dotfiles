-- set paths
home = os.getenv("HOME")
images = home .. "/.config/awesome/images/"
themes = home .. "/.config/awesome/themes/"

-- Theme
theme = (themes .. "cobalt.lua")

-- Standard Programs
terminal	= "termite -e 'tmux -2'"
browser		= "chromium"
editor		= "vim"
guieditor	= "subl3"

-- fonts
fontwidget = "Bitsumishi 8"

widget = {}
-- File System widget DF script
widget.dfscript = (home .. "/.config/awesome/df.sh")
-- Thermal Zone for CPU temperature
widget.thermalzone = "thermal_zone0"
-- Default drive to show free space
widget.drive = "/home"
-- Time format for clock widget
widget.clock = "%I:%M"
-- Mixer Control to show volume of for volume widget
widget.volume = "Master"
-- Network device used to display network traffic 
widget.network = "wlp3s0"
-- Network device used to display wifi 
widget.wifi = widget.network
-- Battery used to determine battery life
widget.battery = "BAT0"
-- Set to your distro to display number of packages that need updating
widget.distro = "Arch"

-- Modifier keys
modkey 		= "Mod4"
hyper       = "Mod3"
altkey		= "Mod1"

-- Other
space = 32
