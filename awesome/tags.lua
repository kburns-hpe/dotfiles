-- Layouts
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
}


--  Tags
-- Define a tag table which will hold all screen tags.
tags = {
  names  = { "", "" ,"", "", "", "", "", "", "" },
  layout = { layouts[4], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2], layouts[1], layouts[6]  }}

for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, tags.layout)
end


mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}

mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
		client.focus = c
	else
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
			client.focus = c
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
	end
end),
-- right mouse: my nav menu
awful.button({ }, 3, function (c)
	client.focus = c
	instance = showNavMenu({ width=100 })
end),
awful.button({ }, 4, function ()
	awful.client.focus.byidx(1)
	if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
end),
-- middle mouse: swap client to master
awful.button({ }, 2, function (c)
	if c == client.focus then
		--  c.minimized = true
		client.focus = c
		c:swap(awful.client.getmaster())
	else
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
			client.focus = c
			c:swap(awful.client.getmaster())
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
		c:swap(awful.client.getmaster())
	end
end)
)
