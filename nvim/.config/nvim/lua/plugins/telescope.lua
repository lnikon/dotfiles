local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        -- Place the previewer and the prompt vertically
        layout_strategy = 'vertical',
    }
})

-- require("telescope").load_extension "file_browser"

local function open_diagnostics_for_current_buffer()
  builtin.diagnostics({bufnr=0})
end

-- Configure mappings
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>r', builtin.lsp_references, {})
vim.keymap.set("n", "<leader>e", ":Telescope file_browser grouped=true path=%:p:h select_buffer=true<CR>")
vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>d', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>i', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>di', open_diagnostics_for_current_buffer, {})
vim.keymap.set('n', '<leader>rr', require('telescope.builtin').registers, {})

