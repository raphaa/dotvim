" Pathogen load
filetype off

set nocompatible
autocmd!

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on
syntax on

set hidden
set backspace=indent,eol,start
set smartindent
set smarttab
set fileencodings=utf-8,latin-1
set laststatus=2
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [pos=%04l,%04v][%p%%]\ [len=%L]
set number
set noeol
set grepprg=ack
set autoread
set noswapfile
set nobackup
set completeopt=menuone,longest,preview
set ignorecase
set smartcase
set hlsearch
set incsearch

colorscheme ir_black

let g:SuperTabDefaultCompletionType = "context"
" This is not very good...
let $DJANGO_SETTINGS_MODULE='settings'
" Python-mode settings
let g:pymode_breakpoint = 0
let g:pymode_lint_write = 0
let g:pymode_folding = 0
let g:pymode_indent = 0

highlight clear SignColumn

" Mappings
let mapleader = ","
map <leader>td <Plug>TaskList
map <leader>a <Esc>:Ack! 
map <silent>,/ :nohlsearch<CR>
map <leader>df :Gdiff<CR>
imap <leader>bp <ESC>:call InsertLine('o')<CR>
imap <leader>bP <ESC>:call InsertLine('O')<CR>
map <leader>bp :call InsertLine('o')<CR>
map <leader>bP :call InsertLine('O')<CR>
map <leader>e <Esc>:e 
map <leader>E <Esc>:e .<CR>
map <leader>tb <Esc>:Tube 
map <leader>gb <Esc>:Gblame<CR>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

if has("gui_running")
	set guioptions=egmrt
	let macvim_hig_shift_movement = 1
	set guifont=Monaco:h13
	let g:tube_terminal = 'iterm'
endif

" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function LoadVirtualEnv(path)
    let activate_this = a:path . '/bin/activate_this.py'
    if getftype(a:path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction

" Load up a 'stable' virtualenv if one exists in ~/.virtualenv
let defaultvirtualenv = $HOME . "/.virtualenvs/stable"

" Only attempt to load this virtualenv if the defaultvirtualenv
" actually exists, and we aren't running with a virtualenv active.
if has("python")
    if empty($VIRTUAL_ENV) && getftype(defaultvirtualenv) == "dir"
        call LoadVirtualEnv(defaultvirtualenv)
    endif
endif

function! InsertLine(insert)
  let trace = expand('import ipdb; ipdb.set_trace()')
  execute 'normal '.a:insert.trace
endfunction

" Add custom snippets
let g:snippets_dir = "~/.vim/bundle/snipmate/snippets/,~/.vim/snippets/"

autocmd FileType python highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType python match OverLength /\%81v.\+/
autocmd FileType python set expandtab shiftwidth=4 tabstop=4 softtabstop=4 omnifunc=pythoncomplete#Complete
autocmd FileType javascript set expandtab shiftwidth=2 tabstop=2 softtabstop=2 omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set expandtab shiftwidth=2 tabstop=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags
autocmd FileType htmldjango set expandtab shiftwidth=2 tabstop=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set expandtab shiftwidth=2 tabstop=2 softtabstop=2 omnifunc=csscomplete#CompleteCSS
autocmd FileType less set expandtab shiftwidth=2 tabstop=2 softtabstop=2 omnifunc=csscomplete#CompleteCSS
