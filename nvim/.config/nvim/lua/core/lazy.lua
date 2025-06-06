-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim
-- https://lazy.folke.io/

--[[
For information about installed plugins see the README:
neovim-lua/README.md: Plugins
https://github.com/brainfucksec/neovim-lua?tab=readme-ov-file#plugins
--]]

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Start setup
lazy.setup({
	spec = {
		{
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},

		--[[
    Colorscheme:
    The colorscheme should be available when starting Neovim.
    Current available color schemes: onedark, kanagawa, monokai, rose-pine
    See: /nvim/lua/core/colors.lua
    --]]
		{
			"navarasu/onedark.nvim",
			lazy = false, -- make sure we load this during startup if it is your main colorscheme
			priority = 1000, -- make sure to load this before all the other start plugins
		},

		-- Other color schemes:
		{ "rebelot/kanagawa.nvim", lazy = true },
		{ "tanvirtin/monokai.nvim", lazy = true },
		{ "rose-pine/neovim", name = "rose-pine", lazy = true },

		-- Icons
		{ "kyazdani42/nvim-web-devicons", lazy = true },

		-- Dashboard (start screen)
		{
			"goolord/alpha-nvim",
			dependencies = { "kyazdani42/nvim-web-devicons" },
		},

		-- Git labels
		{
			"lewis6991/gitsigns.nvim",
			lazy = true,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("gitsigns").setup({})
			end,
		},

		-- Greatest Git plugin
		{
			"tpope/vim-fugitive",
			lazy = false,
		},

		-- tpope really rocks!
		{
			"tpope/vim-surround",
			lazy = false,
		},

		{
			"tpope/vim-endwise",
			lazy = false,
		},

		{
			"tpope/vim-obsession",
			lazy = false,
		},

		-- Better motions
		{
			"easymotion/vim-easymotion",
			lazy = false,
		},

		-- File explorer
		{
			"kyazdani42/nvim-tree.lua",
			dependencies = { "kyazdani42/nvim-web-devicons" },
		},

		-- Statusline
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		},

		-- Treesitter
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

		-- Indent line
		{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

		-- Tag viewer
		{ "preservim/tagbar" },

		-- Autopair
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},

		-- LSP
		{ "neovim/nvim-lspconfig" },

		-- Autocomplete
		{
			"hrsh7th/nvim-cmp",
			-- load cmp on InsertEnter
			event = "InsertEnter",
			-- these dependencies will only be loaded when cmp loads
			-- dependencies are always lazy-loaded unless specified otherwise
			dependencies = {
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"saadparwaiz1/cmp_luasnip",
			},
		},

		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
		},

		-- Formatting
		{
			"mhartington/formatter.nvim",
		},

		-- AI
		{
			-- "github/copilot.vim",
		},

		-- Session management
		{
			"jedrzejboczar/possession.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		},

		-- Bufferline
		{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	},
})
