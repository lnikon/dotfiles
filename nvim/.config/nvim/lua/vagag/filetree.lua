require("neo-tree").setup({
	default_component_configs = {
		file_size = {
			enabled = false,
		},
		type = {
			enabled = false,
		},
		last_modified = {
			enabled = false,
		},
		created = {
			enabled = false,
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
	},
	window = {
		width = "100%",
	},
})

vim.keymap.set("n", "<leader>e", ":Neotree toggle current reveal_force_cwd<cr>")
-- vim.keymap.set("n", "<leader>nb", ":Neotree float buffers<cr>")
-- vim.keymap.set("n", "<leader>ns", ":Neotree float git_status<cr>")
