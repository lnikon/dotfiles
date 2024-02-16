-- require("neodev").setup({})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function (client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'clangd', 'lua_ls', 'rust_analyzer', 'yamlls', 'jsonls', 'marksman', 'pyright', 'eslint', 'tsserver'},
	handlers = {
		lsp_zero.default_setup,
	},
})

