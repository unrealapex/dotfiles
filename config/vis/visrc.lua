-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	vis:command('set number')
	vis:command('set relativenumbers')
    vis:command('set autoindent')
	vis:command('set expandtab')
    vis:command('set tabwidth 4')
	vis:command('set ignorecase')
	vis:command('set escdelay 1')
	vis:command('set cursorline')
end)
