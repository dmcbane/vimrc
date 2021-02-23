" General Settings
set nocompatible
"" source $VIMRUNTIME/vimrc_example.vim
"" source $VIMRUNTIME/mswin.vim

set hidden " TextEdit might fail if hidden is not set.
set encoding=utf-8
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set backspace=indent,eol,start " Fix backspace indent
set clipboard=unnamedplus

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Give more space for displaying messages
set cmdheight=2

" Having longer updatetime (default is 4000ms = 4 s) leads to
" noticible delays and poor user experience.
set updatetime=300

" Don't pass message to |ins-completion-menu|.
set shortmess+=c

" setup MS Windows key bahaviors with the exception of allowing arrow keys to
" extend the selection in visual mode
"" behave mswin
"" set keymodel-=stopsel

if !has('nvim')
    set pythonthreedll=python39.dll
endif

set path+=**

filetype plugin indent on
syntax on

" Install vim-plug
" portable neovim path
"" let s:configpath = fnamemodify(stdpath('config'), ':p')
" linux/osx vim path
let s:configpath = fnamemodify('~/.vim', ':p')
" windows vim path
"" let s:configpath = fnamemodify($MYVIMRC, ':p:h')

let s:plugfilename = s:configpath .. '/autoload/plug.vim'
let s:vim_settings = s:configpath .. '/settings'


if empty(glob(s:plugfilename))
  execute 'silent !curl -fLo' shellescape(s:plugfilename) ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'theJian/elm.vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

let mapleader=','

" Function to source all .vim files in directory
function! SourceDirectory(file)
    for l:fpath in split(globpath(a:file, '*.vim'), '\n')
        exe 'source' l:fpath
    endfor
endfunction

call SourceDirectory(s:vim_settings)

