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

"set textwidth=80
set wrap

set expandtab
set shiftwidth=2
set softtabstop=2
set smarttab
set cindent

" Buffer autocommands
autocmd BufEnter * set cursorline
autocmd BufLeave * set nocursorline
autocmd BufWritePre * :Trim

" Read JSON files as JavaScript
autocmd BufNewFile,BufRead *.json set ft=javascript

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

set ttimeoutlen=50  " Make Esc work faster

" Make the cursor pretty and friendly and nice
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=2\x7"

" Add helpful Rails commands for common patterns
autocmd User Rails nnoremap <buffer> <D-r> :<C-U>Rake<CR>
autocmd User Rails nnoremap <buffer> <D-R> :<C-U>.Rake<CR>
autocmd User Rails Rnavcommand decorator app/decorators -suffix=_decorator.rb -default=model()
autocmd User Rails Rnavcommand presenter app/presenters -suffix=_presenter.rb -default=model()
autocmd User Rails Rnavcommand uploader app/uploaders -suffix=_uploader.rb -default=model()
autocmd User Rails Rnavcommand steps features/step_definitions spec/steps -suffix=_steps.rb -default=web
autocmd User Rails Rnavcommand blueprint spec/blueprints -suffix=_blueprint.rb -default=model()
autocmd User Rails Rnavcommand factory spec/factories -suffix=_factory.rb -default=model()
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()
autocmd User Rails Rnavcommand feature features -suffix=.feature -default=cucumber
autocmd User Rails Rnavcommand serializer app/serializers -suffix=_serializer.rb -default=model()
autocmd User Rails Rnavcommand support spec/support features/support -default=env
autocmd User Rails Rnavcommand worker app/workers -suffix=_worker.rb -default=model()
autocmd User Rails Rnavcommand javascript app/assets/javascripts -suffix=.js -default=model()
autocmd User Rails Rnavcommand less app/assets/stylesheets -suffix=.less -default=model()
autocmd User Rails Rnavcommand stylesheet app/assets/stylesheets -suffix=.scss -default=model()
autocmd User Rails Rnavcommand task lib/tasks -suffix=.rake -default=model()
autocmd User Fugitive command! -bang -bar -buffer -nargs=* Gpr :Git<bang> pull --rebase <args>$

" Extend HTML indentation
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" Disable auto-compilation of LESS files
autocmd! BufWritePost *.less
autocmd! FileWritePost *.less
