-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- fuzzy finder over lists
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- colorscheme
	use({
		"rose-pine/neovim",
		name = "rose-pine",
	})

	use({
		"navarasu/onedark.nvim",
	})

	-- better highlighting and text object handling
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- don't talk to me if you don't know this plugin
	use({
		"tpope/vim-fugitive",
	})

	-- collection of pluings to work with LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			-- Ordering of mason.nvim - nvim-lint - mason-nvim-lint is important
			{ "williamboman/mason.nvim" },
			{ "mfussenegger/nvim-lint" },
			{ "rshkarin/mason-nvim-lint" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
		},
	})

	-- file explorer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- annotations
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- follow only stable versions
		tag = "*",
	})

	use({
		"mhartington/formatter.nvim",
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"mfussenegger/nvim-dap",
		requires = { "nvim-neotest/nvim-nio" },
	})

	use({
		"mxsdev/nvim-dap-vscode-js",
		requires = { "mfussenegger/nvim-dap" },
	})

	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})

	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({
		"m4xshen/hardtime.nvim",
	})

	-- provide lsp features for nvim's builtin globals
	-- use {
	--     "folke/neodev.nvim"
	-- }

	-- more colors!
	-- use {
	--     "folke/tokyonight.nvim"
	-- }

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})
end)
