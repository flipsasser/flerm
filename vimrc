" PATHOGEN
call pathogen#infect()
syntax on
filetype plugin indent on

" GUI configuration
colorscheme molokai
set number
set guifont=Monaco:h14
set visualbell
set splitright
set splitbelow

set guioptions-=T guioptions-=e guioptions-=L guioptions-=r
set shell=bash
syntax on

set textwidth=80
set wrap

set expandtab
set shiftwidth=2
set softtabstop=2

" Buffer autocommands
autocmd BufEnter * set cursorline
autocmd BufLeave * set nocursorline
autocmd BufWritePre * :Trim

" Read JSON files as JavaScript
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.less set ft=css

" NERDCommenter shortcuts
nmap \\           <Plug>NERDCommenterInvert
xmap \\           <Plug>NERDCommenterInvert

" Pane navigation shortcuts
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
nmap , 10<C-W>>
nmap . 10<C-W><

" Disable arrow keys to force me to LEARN
nmap <Down> <>
nmap <Up> <>
nmap <Left> <>
nmap <Right> <>
