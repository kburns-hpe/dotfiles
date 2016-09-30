-- Disable Animation
hs.window.animationDuration = 0

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- Trigger existing hyper key shortcuts

k:bind({}, '\\', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, '\\') end)

-- OR build your own

launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

-- Single keybinding for app launch
singleapps = {
  {'t', 'iTerm 2'},
  {'b', 'Safari'},
}

for i, app in ipairs(singleapps) do
  k:bind({}, app[1], function() launch(app[2]); k:exit(); end)
end

-- Sequential keybindings, e.g. Hyper-a,f for Finder
a = hs.hotkey.modal.new({}, "F16")
apps = {
  {'d', 'Twitter'},
  {'f', 'Finder'},
}
for i, app in ipairs(apps) do
  a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
end

pressedA = function() a:enter() end
releasedA = function() end
k:bind({}, 'a', nil, pressedA, releasedA)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'TAB')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- Full Screen
k:bind({}, "o", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Top Half
k:bind({}, "k", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = 0
    f.y = 0
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Bottom Half
k:bind({}, "l", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = 0
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Left Half
k:bind({}, "j", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Right Half
k:bind({}, ";", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Top Left
k:bind({}, "u", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Top Right
k:bind({}, "i", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Bottom Right
k:bind({}, "m", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Bottom Left
k:bind({}, "n", nil, function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  else
    hs.alert.show("No Active Window")
  end
end)

-- Hint Keys
hs.hints.hintChars = {"A","S","D","F","J","K","L"}

-- Disable Showing Titles
hs.hints.showTitleThresh = 0

-- Hint Shortcut
hs.hotkey.bind('option', 'space ', nil, function()
  hs.hints.windowHints()
end)

-- Switch Window Focus
k:bind({}, '[', nil, function()
  if hs.window.focusedWindow() then
    hs.window.focusedWindow():focusWindowWest()
  else
    hs.alert.show("No Active Window")
  end
end)

k:bind({}, ']', nil, function()
  if hs.window.focusedWindow() then
    hs.window.focusedWindow():focusWindowEast()
  else
    hs.alert.show("No Active Window")
  end
end)

k:bind({}, '-', nil, function()
  if hs.window.focusedWindow() then
    hs.window.focusedWindow():focusWindowNorth()
  else
    hs.alert.show("No Active Window")
  end
end)

k:bind({}, '=', nil, function()
  if hs.window.focusedWindow() then
    hs.window.focusedWindow():focusWindowSouth()
  else
    hs.alert.show("No Active Window")
  end
end)
