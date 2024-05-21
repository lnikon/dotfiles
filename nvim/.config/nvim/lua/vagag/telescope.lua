local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        -- Place the previewer and the prompt vertically
        layout_strategy = 'vertical',
    }
})

require("telescope").load_extension "file_browser"

-- Configure mappings
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fsl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gbr', builtin.git_branches, {})
vim.keymap.set('n', '<leader>trs', builtin.treesitter, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fe", ":Telescope file_browser grouped=true path=%:p:h select_buffer=true<CR>")
