local nvim_lint = require('lint')

require ('mason-nvim-lint').setup({
    ensure_installed = {'hadolint', 'quick-lint-js', 'eslint_d'},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
