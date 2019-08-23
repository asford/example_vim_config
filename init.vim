set encoding=utf-8

call plug#begin("~/.vim/plugged")

" Generic navigation plugins
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'adelarsq/vim-matchit'

" Git support plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" Unix file operations
Plug 'tpope/vim-eunuch'

" Async make dispatch
Plug 'tpope/vim-dispatch'

" File tree
Plug 'scrooloose/nerdtree'

" Comment/Uncomment bindings
Plug 'scrooloose/nerdcommenter'

" Undo tree
Plug 'simnalamburt/vim-mundo'


""" Code formatting/linting
" Autoformat
Plug 'Chiel92/vim-autoformat'
" Lint
Plug 'w0rp/ale'
" Python autocomplete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Mark file with errors from quickfix
Plug 'dhruvasagar/vim-markify'

""" Filetypes
" Markdown filetype
Plug 'tpope/vim-markdown'

""" Statusline support
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

call plug#end()

""" tempfile layout
" From https://github.com/docwhat/homedir-vim/
" Uses // at the end of directories to avoid filename collisions.
"
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim-backup') == 0
 :silent !mkdir -p ~/.vim-backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim-backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim-swap') == 0
 :silent !mkdir -p ~/.vim-swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim-swap//
set directory+=~/tmp//
set directory+=.

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim-undo') == 0
  :silent !mkdir -p ~/.vim-undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim-undo//
  set undofile
endif

"""" Display options

" Language options
syntax on
filetype plugin indent on
set modeline

set ruler
set number
set showmode
set showcmd

set linebreak "Smart line breaks
set display+=lastline "Display partial last lines
set backspace=start,eol,indent
set listchars=tab:→\ ,trail:·

" Active cursor setings, use vertical bar for insert, block for normal.
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[2 q"
let &t_EI = "\<Esc>[2 q"

set visualbell
set shm+=I "No intro

" Color options
set t_Co=256
colorscheme wombat

" Spacing options
set shiftwidth=2
set tabstop=2
set expandtab
set cindent
set autoindent

" Substitute options
set gdefault

" Mapping options
let mapleader = ","
noremap ; :

"""" NERDTree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$']

let g:NERDTreeMapOpenSplit = '<C-s>'
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeMapOpenInTab = '<C-t>'

" config for wildignore
set wildignore+=*.pyc,*.DS_Store,__pycache__
let NERDTreeRespectWildIgnore=1

"""" NERDCommenter
let NERDDefaultAlign="left"

"""" Mundo
nnoremap <silent> <Leader>u :MundoToggle<CR>

"""" Vim fugitive
" Auto unload fugitive buffers when hidden
autocmd BufReadPost fugitive://* set bufhidden=delete

"""" Pytest dispatch aliases

command -nargs=* -complete=file Pytest FocusDispatch pytest --tb=short --ff --instafail -r fE <args>
command -nargs=* -complete=file Dpytest FocusDispatch pytest --pdb --tb=short --ff --instafail -r fE <args>
command -nargs=* -complete=file DPytest FocusDispatch pytest --pdb --tb=short --ff --instafail -r fE <args>

"""" Youcompleteme
" let g:ycm_path_to_python_interpreter = 'python'
" Use the environment's python intepreter for completions
let g:ycm_python_binary_path = 'python'

"""" Terminal mousing support
set mouse=a
set ttymouse=xterm2

"""" vim-autoformat settings
let g:autoformat_verbosemode = 0
let g:autoformat_retab = 0
let g:autoformat_autoindent = 0

"""" Copypasta support
"" copy the current text selection to the system clipboard
if has('gui_running') || has('nvim') && exists('$DISPLAY')
  noremap <Leader>yy "+y
else
  " copy to attached terminal using the yank(1) script:
  " https://github.com/sunaku/home/blob/master/bin/yank
  noremap <silent> <Leader>yy y:call system('yank > /dev/tty', @0)<Return>
endif
