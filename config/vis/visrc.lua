-- load standard vis module, providing parts of the Lua API
require("vis")

-- built in plugins
require("plugins/filetype")
require("plugins/complete-filename")
require("plugins/complete-word")

-- external plugins

-- bootstrap vis-plug
local visplugpath = os.getenv("XDG_CONFIG_HOME") .. "/vis/vis-plug"
local file_exists = function(path)
        local file = io.open(path)
        if not file then return false end
        file:close()
        return true
end


if not file_exists(visplugpath)
then
  print("vis-plug not found, installing...")
  os.execute("git clone --filter=blob:none https://github.com/erf/vis-plug " .. visplugpath)
end

local plug = require("vis-plug")

local plugins = {
  { "https://github.com/milhnl/vis-format" },
  { "https://github.com/lutobler/vis-commentary" },
  { "https://gitlab.com/muhq/vis-lspc", alias = "lspc" },
  { "https://github.com/lutobler/vis-modelines" },
  { "https://github.com/e-zk/vis-shebang" },
  { "https://repo.or.cz/vis-surround" },
  { "https://git.cepl.eu/cgit/vis/vis-jump" },
  { "https://git.cepl.eu/cgit/vis/vis-yank-highlight" },
  { "https://github.com/jocap/vis-filetype-settings" },
}

plug.init(plugins, true)

shebangs = {
  ["#!/bin/sh"] = "bash",
}

plug.plugins.lspc.menu_cmd = "vis-menu"

settings = {
    bash  = function()
	    vis:command("set expandtab on")
	    vis:command("set tabwidth 2")
    end,
    -- vis does not have an sh filetype
    -- sh = function()
	    -- vis:command("set expandtab on")
	    -- vis:command("set tabwidth 2")
    -- end,
    lua = function()
	    vis:command("set expandtab on")
	    vis:command("set tabwidth 2")
    end,
    markdown = function()
	    vis:command("set expandtab on")
	    vis:command("set tabwidth 4")
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

vis.events.subscribe(vis.events.INIT, function() end)

vis.events.subscribe(
  vis.events.WIN_OPEN,
  function(win) -- luacheck: no unused args
    -- Your per window configuration options e.g.
    vis:command("set number")
    vis:command("set relativenumbers")
    vis:command("set autoindent")
    vis:command("set tabwidth 4")
    vis:command("set ignorecase")
    vis:command("set escdelay 1")
    vis:command("set cursorline")

    vis:map(vis.modes.NORMAL, "]d", function()
        vis:command("lspc-next-diagnostic")
    end)
    
    vis:map(vis.modes.NORMAL, "[d", function()
        vis:command("lspc-prev-diagnostic")
    end)

    vis:map(vis.modes.NORMAL, "gh", function()
        vis:command("lspc-hover")
    end)

    vis:map(vis.modes.NORMAL, "gq", function()
        vis:command("lspc-format")
    end)

  end
)
