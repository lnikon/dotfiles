local ls = require("luasnip")

-- Key mappings for jumping to the next and previous nodes
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.luasnip_jump(1)", { expr = true, noremap = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.luasnip_jump(1)", { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.luasnip_jump(-1)", { expr = true, noremap = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.luasnip_jump(-1)", { expr = true, noremap = true })

-- Define the jump function
function _G.luasnip_jump(dir)
	if ls.jumpable(dir) then
		ls.jump(dir)
	else
		return dir == 1 and "<Tab>" or "<S-Tab>"
	end
end
