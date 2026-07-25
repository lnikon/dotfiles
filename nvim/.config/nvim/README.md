# Neovim Configuration

Minimal Neovim 0.12 config. Relies on Neovim's built-in LSP keymaps, native
completion, native formatting, and the native `vim.pack` plugin manager
wherever possible. Only 6 plugins.

## Structure

```
~/.config/nvim/
├── init.lua                    # Bootstrap
├── lua/
│   ├── config/
│   │   ├── options.lua         # Vim options
│   │   ├── plugins.lua         # vim.pack.add() + plugin setup() calls
│   │   ├── lsp.lua             # vim.lsp.enable() + LspAttach autocmd
│   │   ├── autocmds.lua        # Autocommands
│   │   └── keymaps.lua         # All keymaps
│   └── lsp/
│       └── servers.lua         # Custom LSP server configs (clangd, lua_ls, cmake)
└── README.md
```

## Plugins (6)

- **plenary.nvim** - Lua utilities (Neogit dependency)
- **telescope.nvim** - Fuzzy finder
- **oil.nvim** - File manager (edit a directory as a buffer)
- **gitsigns.nvim** - Git hunk signs/staging in the gutter
- **neogit** - Git UI
- **nvim-treesitter** - Syntax highlighting (parsers not bundled with Neovim: c, cpp, lua, cmake)
- **warm-burnout** - Colorscheme

Managed with Neovim's built-in `vim.pack` (see `:h vim.pack`) — no plugin
manager plugin. `vim.pack.update()` checks for updates; its lockfile lives at
`~/.config/nvim/nvim-pack-lock.json`.

## What's built-in instead of a plugin

- **Completion**: `vim.lsp.completion.enable(..., { autotrigger = true })`, wired in `lsp.lua`.
- **Formatting**: `vim.lsp.buf.format()` on save, gated on the attached client supporting it.
- **LSP keymaps**: almost entirely Neovim core defaults — `grn` (rename), `gra`
  (code action), `grr` (references), `gri` (implementation), `grt` (type
  definition), `gO` (document symbols), `K` (hover), `<C-s>` (signature help,
  insert mode), `[d`/`]d`/`[D`/`]D` (diagnostic nav), `<C-w>d` (diagnostic
  float). Only `gd` (go to definition) isn't a default and is added in `lsp.lua`.
- **Comments**: native `gc`/`gcc`.
- **Diagnostics list**: `<leader>xx` → `vim.diagnostic.setloclist()`, no separate UI plugin.

## Key Mappings

- Leader: `,` / Local leader: `\`
- `<C-h/j/k/l>` - window navigation
- `<C-Up/Down/Left/Right>` - window resize
- `-` - open oil.nvim (parent directory of current file)
- `<leader>ff` / `<leader>fg` / `<leader>fb` - telescope find files / live grep / buffers
- `<leader>gg` - open Neogit
- `]c` / `[c` - next/previous git hunk
- `<leader>hs` / `<leader>hr` - stage/reset git hunk
- `gd` - go to definition
- `<leader>f` - format buffer
- `<leader>xx` - buffer diagnostics (location list)
- `gcc` / `gc` - comment line / selection (native)
- `<` / `>` - indent left/right, stays in visual mode

Everything else LSP-related (`grn`, `gra`, `grr`, `gri`, `grt`, `gO`, `K`,
diagnostic nav) is a Neovim core default — see `:h lsp-defaults`.

## LSP servers

- **clangd** - C/C++/Objective-C/CUDA, with `:LspClangdSwitchSourceHeader`
- **lua_ls** - Lua, configured for editing this Neovim config
- **cmake-language-server** - CMake

No Mason — install these via your system package manager (or `pip install
cmake-language-server`) before first use. `ripgrep` is required for
telescope's live grep.

## Installation

1. Neovim >= 0.12 (for `vim.pack` and `vim.lsp.completion.enable`)
2. Install the LSP binaries above, plus `clang-format` for C/C++ formatting
3. Symlink this directory to `~/.config/nvim` and start Neovim — `vim.pack.add()`
   in `plugins.lua` clones the 6 plugins on first run
4. `:restart` once the initial install finishes
