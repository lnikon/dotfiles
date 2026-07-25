-- Set leader keys
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Load config modules
require("config.options")
require("config.plugins") -- vim.pack: installs & configures plugins
require("config.lsp")
require("config.autocmds")
require("config.keymaps")
