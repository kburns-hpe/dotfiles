awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    focus = true,
    keys = clientkeys,
    buttons = clientbuttons,
    size_hints_honor = false } 
  },

  -- Global:
  { rule = { instance = "plugin-container" },
    properties = {floating = false , maximized_vertical = false, maximized_horizontal = false} },
  { rule = { instance = "qt4-ssh-askpass" },
    properties = {floating = true , maximized_vertical = false, maximized_horizontal = false} },
  { rule = { class = "Anamnesis" }, 
    properties = {floating = true , maximized_vertical = false, maximized_horizontal = false} },
  { rule = { class = "Blueman-manager" }, 
    properties = {floating = true , maximized_vertical = false, maximized_horizontal = false} },
  { rule = { class = "Pavucontrol" }, 
    properties = {floating = true , maximized_vertical = false, maximized_horizontal = false} },
  { rule = { class = "Autokey-gtk" }, 
    properties = {floating = true , maximized_vertical = false, maximized_horizontal = false} },
  { rule = { class = "VMwareUnityWindow" },  
    properties = { border_width = 0, floating = true } },

  -- 1: term

  -- 2: web
  { rule = { class = "Chrome" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][2]})
  end },

  { rule = { class = "chromium" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][2]})
  end },

  { rule = { class = "Dwb" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][2]})
  end },

  { rule = { class = "Firefox" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][6]})
  end },

  -- 3: code
  { rule = { class = "Atom" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][3]})
  end },

  { rule = { class = "Subl3" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][3]})
  end },

  { rule = { class = "IDA" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][3]})
  end },

  { rule = { class = "Hopper" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][3]})
  end },

  { rule = { class ="010editor" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][3]})
  end },

  { rule = { class ="Binary Ninja" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][3]})
  end },

  -- 4: notes
  { rule = { name = "Zeal" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][4]})
  end },

  { rule = { name = "Zim" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][4]})
  end },

  { rule = { class = "Nvpy" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][4]})
  end },

  { rule = { class = "Rednotebook" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][4]})
  end },

  { rule = { class = "Evince" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][4]})
  end },

  { rule = { class = "Zathura" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][4]})
  end },

  -- 5: social
  { rule = { class = "Pidgin"},
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][5]})
  end,
    properties = {floating = true , maximized_vertical = false, maximized_horizontal = false} },

  { rule = { name = "HipChat" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][5]})
  end },

  { rule = { instance = "social", class = "Termite" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][5]})
  end },
  -- 6: media
  { rule = { class = "burp-StartBurp" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][6]})
  end },

  { rule = { class = "Mplayer" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][6]})
  end },

  { rule = { class = "Geeqie" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][6]})
  end },
  { rule = { class = "Vlc" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][6]})
  end },

  { rule = { class = "Gimp" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][6]})
  end },

  { rule = { class = "Gimp", role = "toolbox" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][6]})
  end },

      
  -- 7: mail
  { rule = { class = "URxvt", instance = "mutt"},
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][7]})
  end },


  -- 8: float
  { rule = { class = "Steam" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][8]})
  end },

  { rule = { class = "Gnuradio-companion" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][8]})
  end },

  { rule = { class = "Seafile-applet" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][8]})
  end },

  { rule = { class = "CrashPlan" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][8]})
  end },

  { rule = { class = "Spotify" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][8]})
  end },

  { rule = { class = "Wine" }, 
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][8]})
  end },

        
  -- 9: virt
  { rule = { class = "rdesktop" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][9]})
  end },

  { rule = { class = "Remmina" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][9]})
  end },

  { rule = { class = "Vmware" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][9]})
  end },

  { rule = { class = "VirtualBox" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][9]})
  end },

  { rule = { class = "Virt-manager" },
    callback = function(c)
      c.screen = mouse.screen
      c:tags({tags[c.screen][9]})
  end },

}
