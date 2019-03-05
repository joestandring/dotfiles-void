" Relative Numbers
set number relativenumber

" Autocompletion
set wildmode=list:longest,full

" Disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Copy to/from external programs
vnoremap <C-c> "+y
map <C-p> "+p
