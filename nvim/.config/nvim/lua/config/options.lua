-- Hint: use `:h <option>` to figure out the meaning if needed
-- "noselect" so a stray <CR>/<Tab> never accepts an item you didn't pick;
-- "popup" shows the LSP's resolved docs for the selected item
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.mouse = "a" -- allow the mouse to be used in nvim

-- Tab
vim.opt.tabstop = 4        -- number of visual spaces per TAB
vim.opt.softtabstop = 4    -- number of spaces in tab when editing
vim.opt.shiftwidth = 4     -- insert 4 spaces on a tab
vim.opt.expandtab = true   -- tabs are spaces, mainly because of Python
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line

-- UI config
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true     -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true     -- open new vertical split bottom
vim.opt.splitright = true     -- open new horizontal splits right
vim.opt.showmode = false      -- we are experienced, wo don't need the "-- INSERT --" mode hint
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Searching
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = false  -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered

-- Visual settings
vim.opt.termguicolors = true  -- Enable 24-bit colors
vim.opt.signcolumn = "yes"    -- Always show sign column
vim.opt.showmatch = true      -- Highlight matching brackets
vim.opt.matchtime = 2         -- How long to show matching bracket
vim.opt.cmdheight = 1         -- Command line height
vim.opt.pumheight = 10        -- Popup menu height
vim.opt.pumblend = 10         -- Popup menu transparency
vim.opt.winblend = 0          -- Floating window transparency
vim.opt.conceallevel = 2      -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.confirm = true        -- Confirm to save changes before exiting modified buffer
vim.opt.concealcursor = ""    -- Don't hide cursor line markup
vim.opt.synmaxcol = 300       -- Syntax highlighting limit
vim.opt.ruler = false         -- Disable the default ruler
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.winminwidth = 5       -- Minimum window width

-- File handling
vim.opt.backup = false                            -- Don't create backup files
vim.opt.writebackup = false                       -- Don't create backup before writing
vim.opt.swapfile = false                          -- Don't create swap files
vim.opt.undofile = true                           -- Persistent undo
vim.opt.undolevels = 10000
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300                          -- Faster completion
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
vim.opt.ttimeoutlen = 0                           -- Key code timeout
vim.opt.autoread = true                           -- Auto reload files changed outside vim
vim.opt.autowrite = true                          -- Auto save

-- Sessions - drop "blank", add globals/localoptions/winpos
vim.opt.sessionoptions = "buffers,curdir,folds,globals,help,localoptions,tabpages,terminal,winpos,winsize"

-- Behavior settings
vim.opt.hidden = true                                       -- Allow hidden buffers
vim.opt.errorbells = false                                  -- No error bells
vim.opt.backspace = "indent,eol,start"                      -- Better backspace behavior
vim.opt.autochdir = false                                   -- Don't auto change directory
vim.opt.iskeyword:append("-")                               -- Treat dash as part of word
vim.opt.path:append("**")                                   -- include subdirectories in search
vim.opt.selection = "inclusive"                             -- Selection behavior
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.modifiable = true                                   -- Allow buffer modifications
vim.opt.encoding = "UTF-8"                                  -- Set encoding

-- Folding settings
vim.opt.smoothscroll = true
vim.wo.foldmethod = "expr"
vim.opt.foldlevel = 99             -- Start with all folds open
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldlevel = 99

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right
vim.opt.splitkeep = "screen"

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.jumpoptions = "view"
vim.opt.laststatus = 3    -- global statusline
vim.opt.list = false
vim.opt.linebreak = true  -- Wrap lines at convenient points
vim.opt.list = true       -- Show some invisible characters (tabs...
vim.opt.shiftround = true -- Round indent
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

vim.g.markdown_recommended_style = 0
