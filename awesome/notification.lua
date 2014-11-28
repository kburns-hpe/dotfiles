function closeLastNoti()
  screen = mouse.screen
  for p,pos in pairs(naughty.notifications[screen]) do
    for i,n in pairs(naughty.notifications[screen][p]) do
      if (n.width == 258) then -- to close only previous bright/vol notifications
        naughty.destroy(n)
        break
      end
    end
  end
end

-- volume notification
volnotiicon = nil
function volnoti()
  closeLastNoti()
  naughty.notify{
    icon = volnotiicon,
    position = "top_right",
    fg=black,
    bg=blue,
    border_color = blue,
    timeout=1,
    width = 256,
    screen = mouse.screen,
  }
end

-- brightness notification
brightnotiicon = nil
function brightnoti()
  closeLastNoti()
  naughty.notify{
    icon = brightnotiicon,
    position = "top_right",
    fg=black,
    bg=blue,
    border_color = blue,
    timeout=1,
    width = 256,
    screen = mouse.screen,
  }
end

function run_or_raise(cmd, properties)
  local clients = client.get()
  local focused = awful.client.next(0)
  local findex = 0
  local matched_clients = {}
  local n = 0
  for i, c in pairs(clients) do
    -- make an array of matched clients
    if match(properties, c) then
      n = n + 1
      matched_clients[n] = c
      if c == focused then
        findex = n
      end
    end
  end
  if n > 0 then
    local c = matched_clients[1]
    -- if the focused window matched switch focus to next in list
    if 0 < findex and findex < n then
      c = matched_clients[findex+1]
    end
    local ctags = c:tags()
    if table.getn(ctags) == 0 then
      -- ctags is empty, show client on current tag
      local curtag = awful.tag.selected()
      awful.client.movetotag(curtag, c)
    else
      -- Otherwise, pop to first tag client is visible on
      awful.tag.viewonly(ctags[1])
    end
    -- And then focus the client
    client.focus = c
    c:raise()
    return
  end
  awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
  for k, v in pairs(table1) do
    if table2[k] ~= v and not table2[k]:find(v) then
      return false
    end
  end
  return true
end

-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end
