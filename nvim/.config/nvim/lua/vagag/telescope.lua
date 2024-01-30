local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
	defaults = {
		-- Place the previewer and the prompt vertically
		layout_strategy = 'vertical',
	}
})

-- Configure mappings
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fs', function()
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
	builtin.grep_string({search = vim.fn.input("Grep > ");})
end)
vim.keymap.set('n', '<leader>fss', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fsl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gbr', builtin.git_branches, {})
vim.keymap.set('n', '<leader>trs', builtin.treesitter, {})
