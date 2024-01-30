local nvim_lint = require('lint')

require ('mason-nvim-lint').setup({
    ensure_installed = {'eslint_d'},
})

nvim_lint.linters_by_ft = {
    javascript = {'eslint_d'},
    typescript = {'eslint_d'}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
