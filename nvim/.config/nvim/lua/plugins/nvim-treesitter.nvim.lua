-- Upgrading to 'main' branch f-s up things, to will stay on master for a while.
-- See: https://github.com/nvim-treesitter/nvim-treesitter/discussions/7927
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"proto",
				"cmake",
				"python",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
			},
			sync_install = true,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- Functions
						["af"] = "@function.outer",
						["if"] = "@function.inner",

						-- Classes
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",

						-- Parameters/arguments
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",

						-- Conditionals (if/else blocks)
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",

						-- Loops
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",

						-- Comments
						["aC"] = "@comment.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- Add to jumplist
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
					},
				},
			},
		})
	end,
}
