call plug#begin('~/.local/share/nvim/plugged')

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Syntax checking and error reporting
Plug 'w0rp/ale'

" Surround with charachters
Plug 'tpope/vim-surround'

" Golang features
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" Highlight search results
set hlsearch

" Ignore case when searching
set ignorecase

" Line numbering
set nu

" Disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 'o' and 'O' do not enter insert mode
nnoremap o o<Esc>
nnoremap O O<Esc>

" Spellcheck bind
map<F6> :setlocal spell! spelllang=en_gb<CR>

" Use autocompletion
let g:deoplete#enable_at_startup = 1

" Default indentation and wrapping
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix

" Indentation and wrapping for CSS/HTML/JS
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" Automatically import in Go
let g:go_fmt_command = "goimports"

" 80 line marker
:set colorcolumn=80
