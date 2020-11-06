" General Settings
set nocompatible
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

if !has('nvim')
    set pythonthreedll=python39.dll
endif

set path+=**

filetype plugin indent on
syntax on

" Install vim-plug
" portable neovim path
" let b:configpath = fnamemodify(stdpath('config'), ':p')
" linux/osx vim path
" let b:configpath = fnamemodify('~/.vim', ':p')
" windows vim path
let b:configpath = fnamemodify('~/vimfiles', ':p')

let b:plugfilename = b:configpath . '/autoload/plug.vim'
let b:vim_settings = b:configpath . '/settings'


if empty(glob(b:plugfilename))
  execute 'silent !curl -fLo' shellescape(b:configpath) ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'theJian/elm.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

let mapleader=','

" Function to source all .vim files in directory
function! SourceDirectory(file)
    for s:fpath in split(globpath(a:file, '*.vim'), '\n')
        exe 'source' s:fpath
    endfor
endfunction

call SourceDirectory(b:vim_settings)

