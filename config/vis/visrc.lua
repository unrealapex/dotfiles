-- load standard vis module, providing parts of the Lua API
require("vis")

-- built in plugins
require("plugins/filetype")
require("plugins/complete-filename")
require("plugins/complete-word")

-- external plugins
local plug = require("plugins/vis-plug")
if os.getenv("XDG_DATA_HOME") then
  plug.path(os.getenv("XDG_DATA_HOME") .. "/vis/plugins")
else
  plug.path("~/.local/share/vis/plugins")
end

local plugins = {
  { "https://github.com/milhnl/vis-format" },
  { "https://github.com/lutobler/vis-commentary" },
  { "https://gitlab.com/muhq/vis-lspc" },
  { "https://github.com/lutobler/vis-modelines" },
  { "https://github.com/e-zk/vis-shebang" },
  { "https://repo.or.cz/vis-surround" },
  { "https://git.cepl.eu/cgit/vis/vis-jump" },
  { "https://git.cepl.eu/cgit/vis/vis-yank-highlight" },
}

plug.init(plugins, true)

shebangs = {
  ["#!/bin/sh"] = "bash",
}

-- TODO: lazy load this
require("plugins/vis-format")
require("plugins/vis-commentary")
require("plugins/vis-lspc")
require("plugins/vis-modelines")
require("plugins/vis-shebang")
require("plugins/vis-surround")
require("plugins/vis-jump")
require("plugins/vis-yank-highlight")

require("plugins/vis-lspc").menu_cmd = "vis-menu"

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
    vis:map(vis.modes.NORMAL, "=", require("plugins/vis-format").apply)
  end
)
