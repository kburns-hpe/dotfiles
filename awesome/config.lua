-- set paths
home = os.getenv("HOME")
images = home .. "/.config/awesome/images/"
themes = home .. "/.config/awesome/themes/"

-- Theme
theme = (themes .. "cobalt.lua")

-- Standard Programs
terminal	= "termite -e tmux"
browser		= "chromium"
editor		= "vim"
guieditor	= "subl3"

-- fonts
fontwidget = "Bitsumishi 8"

widget = {}
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
-- Set this to dual if BAT0 and BAT1 are both used
widget.battery = "BAT0"
-- Use power_now or current_now + voltage_now to determine power usage
battype = "current_now"
-- Set to your distro to display number of packages that need updating
widget.distro = "Arch"
-- Set this to an array of mailbox directories
widget.mailbox = { '/home/user/email1/Inbox', '/home/user/email2/Inbox' }

-- Modifier keys
modkey 		= "Mod4"
hyper       = "Mod3"
altkey		= "Mod1"

-- Other
space = 32
