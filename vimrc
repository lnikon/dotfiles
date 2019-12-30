set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
filetype off          " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' 
" better experience with git from vim
Plugin 'tpope/vim-fugitive'

" autocompletion for C/C++
Plugin 'xavierd/clang_complete'

" syntax highlight
Plugin 'octol/vim-cpp-enhanced-highlight'

" file explorer
Plugin 'tpope/vim-vinegar'

" lsp support
Plugin 'm-pilia/vim-ccls'
Plugin 'dense-analysis/ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required

let mapleader=","            " override default leader
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
colorscheme desert        " set colorscheme
set number                " show line numbers
set laststatus=2          " last window always has a statusline
filetype indent on        " activates indenting for files
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text

""" clang_complete
let g:clang_library_path='/usr/lib/libclang.so'

""" C++ syntax highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

""" lsp support
let g:ale_cpp_ccls_init_options = {
            \   'cache': {
            \       'directory': '/tmp/ccls/cache'
            \   }
            \ }

""" ALE provided completion
let g:ale_completion_enabled = 1

""" ALE provided code navigation
nn <silent> <leader>d :ALEGoToDefinition<cr>
nn <silent> <M-r> :ALEFindReferences<cr>
nn <silent> <M-a> :ALESymbolSearch<cr>
nn <silent> <M-h> :ALEHover<cr>
