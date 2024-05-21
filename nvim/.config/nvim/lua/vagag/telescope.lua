local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        -- Place the previewer and the prompt vertically
        layout_strategy = 'vertical',
    }
})

require("telescope").load_extension "file_browser"

local function open_diagnostics_for_current_buffer()
  builtin.diagnostics({bufnr=0})
end

-- Configure mappings
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fsl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>gbr', builtin.git_branches, {})
vim.keymap.set('n', '<leader>trs', builtin.treesitter, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fe", ":Telescope file_browser grouped=true path=%:p:h select_buffer=true<CR>")
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gci', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>di', open_diagnostics_for_current_buffer, {})
