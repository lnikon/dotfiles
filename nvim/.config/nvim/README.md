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

## Plugins (10)

- **plenary.nvim** - Lua utilities (Neogit dependency)
- **telescope.nvim** - Fuzzy finder
- **oil.nvim** - File manager (edit a directory as a buffer)
- **gitsigns.nvim** - Git hunk signs/staging in the gutter
- **diffview.nvim** - Diff/history views (Neogit dependency)
- **neogit** - Git UI
- **nvim-treesitter** - Syntax highlighting (parsers not bundled with Neovim: c, cpp, lua, cmake)
- **mason.nvim** - LSP server installer
- **persistence.nvim** - Sessions
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
- `<leader>qs` / `<leader>ql` - restore session for cwd / last session
- `<leader>qS` / `<leader>qd` - pick a session / stop saving this one
- `gcc` / `gc` - comment line / selection (native)
- `<` / `>` - indent left/right, stays in visual mode

Everything else LSP-related (`grn`, `gra`, `grr`, `gri`, `grt`, `gO`, `K`,
diagnostic nav) is a Neovim core default — see `:h lsp-defaults`.

## Sessions

`persistence.nvim` saves a session per working directory (and per git branch,
when it isn't `main`/`master`) to `~/.local/state/nvim/sessions/`. Saving is
automatic on exit; restoring never is — Neovim always starts clean and you ask
for the session with `<leader>qs`. `sessionoptions` is set in `options.lua`.

## LSP servers

Installed and updated with `mason.nvim` (`:Mason` for the UI). The server
list lives in `lua/lsp/servers.lua`, which maps each `vim.lsp` config name to
its Mason package; `plugins.lua` installs anything missing on startup. Mason
prepends `~/.local/share/nvim/mason/bin` to `PATH`, so the `cmd` in each server
config resolves to the Mason copy rather than a system one.

- **clangd** - C/C++/Objective-C/CUDA, with `:LspClangdSwitchSourceHeader`
- **lua_ls** - Lua, configured for editing this Neovim config
- **neocmakelsp** - CMake (Rust binary; replaced the Python `cmake-language-server`
  so Mason never has to build a pip venv)

`ripgrep` is required for telescope's live grep.

## Installation

1. Neovim >= 0.12 (for `vim.pack` and `vim.lsp.completion.enable`)
2. Symlink this directory to `~/.config/nvim` and start Neovim — `vim.pack.add()`
   in `plugins.lua` clones the plugins, then Mason installs the LSP servers
3. `:restart` once the initial install finishes (`:Mason` shows progress)
4. `clang-format` still comes from your system package manager (C/C++ formatting)
