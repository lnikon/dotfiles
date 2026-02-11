-- Set leader keys
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Load config modules
require("config.options")
require("config.lazy") -- Loads all plugins
require("config.autocmds")
require("config.keymaps")

-- OCaml support
vim.opt.rtp:prepend("/home/nikon/.opam/default/share/ocp-indent/vim")
