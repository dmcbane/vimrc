" General Settings
if has('win32') && !has('nvim')
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
endif

set hidden " TextEdit might fail if hidden is not set.
set encoding=utf-8
scriptencoding utf-8
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set backspace=indent,eol,start " Fix backspace indent
set clipboard=unnamedplus
set laststatus=2

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

if has('win32')
    " setup MS Windows key bahaviors with the exception of allowing arrow keys to
    " extend the selection in visual mode
    behave mswin
    set keymodel-=stopsel

    if !has('nvim')
       set pythonthreedll=python314.dll
    endif
endif

set path+=**

filetype plugin indent on
syntax on

" Function to source all files matching glob in directory
function! SourceDirectory(folder, glob)
    for l:fpath in split(globpath(a:folder, a:glob), '\n')
        exe 'source' l:fpath
    endfor
endfunction

" Install vim-plug
if has('nvim')
    " portable neovim path
    let s:configpath = fnamemodify(stdpath('config'), ':p')
elseif has('macunix') || has('unix') || has('win32unix')
    " linux/osx vim path
    let s:configpath = fnamemodify('~/.vim', ':p')
elseif has('win32')
    " windows vim path
    let s:configpath = fnamemodify($MYVIMRC, ':p:h')
endif

let s:plugfilename = s:configpath . 'autoload/plug.vim'
let s:vim_settings = s:configpath . 'settings'

" let g:dale_configpath=s:configpath
" let g:dale_plugfilename=s:plugfilename
" let g:dale_vim_settings=s:vim_settings

if empty(glob(s:plugfilename))
    execute 'silent !curl -fLo' shellescape(s:plugfilename) ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

call SourceDirectory(s:vim_settings, '*.plug')

call plug#end()

let mapleader=','

" should we perform GUI setup?
if has('termguicolors')
    set termguicolors
endif
let g:use_gui = exists('g:neovide') || has('gui_running') || (has('termguicolors') && &termguicolors)

function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv


call SourceDirectory(s:vim_settings, '*.vim')
