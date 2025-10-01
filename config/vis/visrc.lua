-- load standard vis module, providing parts of the Lua API
require("vis")

require("plugins/vis-format")
require("plugins/vis-commentary")
require("plugins/vis-lspc")
require("plugins/vis-modelines")
require("plugins/vis-surround")
require("plugins/vis-jump")
require("plugins/vis-filetype-settings")
require("plugins/vis-quickfix")
require("plugins/vis-lockfiles")
require("plugins/vis-ins-completion")

require("plugins/vis-lspc").menu_cmd = "vis-menu"

settings = {
	man = function()
		vis:map(vis.modes.NORMAL, "q", function()
			vis:command("q")
		end)
	end,
}

vis:operator_new("=", function(file, range, pos)
	local status, out, err = vis:pipe(file, range, "fmt")
	if not status then
		vis:info(err)
	else
		file:delete(range)
		file:insert(range.start, out)
	end
	return range.start -- new cursor location
end, "Formating operator, filter range through fmt(1)")

vis:command_register("sh", function()
	vis:command("!" .. vis.options.shell)
	return true;
end, "Spawn shell")

vis.events.subscribe(vis.events.INIT, function() end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	vis:command("set autoindent")
	vis:command("set cursorline")
	vis:command("set escdelay 1")
	vis:command("set ignorecase")
	vis:command("set number")

	vis:map(vis.modes.NORMAL, "]d", ":lspc-next-diagnostic<Enter>")
	vis:map(vis.modes.NORMAL, "[d", ":lspc-prev-diagnostic<Enter>")
	vis:map(vis.modes.NORMAL, "gh", ":lspc-hover<Enter>")
	vis:map(vis.modes.NORMAL, "n", "<vis-motion-search-repeat>")
	vis:map(vis.modes.NORMAL, "N", "<vis-motion-search-repeat-reverse>")
end)
