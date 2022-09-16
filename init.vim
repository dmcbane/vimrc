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
        set pythonthreedll=python39.dll
    endif
endif

set path+=**

filetype plugin indent on
syntax on

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

"" " Conjure
"" Plug 'Olical/conjure', {'tag': 'v4.3.1'}
"" " Conjure support - jack-in with nrepl dependencies
"" Plug 'tpope/vim-dispatch'
"" Plug 'clojure-vim/vim-jack-in'
"" if has('nvim')
""     Plug 'radenling/vim-dispatch-neovim'
"" endif
"" " Conjure code analysis
"" Plug 'dense-analysis/ale'

" Web development
Plug 'mattn/emmet-vim' " abbreviation expansion
"" Plug 'Yggdroot/indentline' " indent indicator
" Plug 'AndrewRadev/tagalong.vim' " tag replacement

" Rails development
Plug 'preservim/nerdtree'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'dense-analysis/ale'
"" if has('nvim')
""   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"" else
""     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
""     Plug 'roxma/nvim-yarp'
""     Plug 'roxma/vim-hug-neovim-rpc'
"" endif
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
"
" Conquer of Completion instead of Deoplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}


Plug 'lifepillar/vim-gruvbox8'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
" Plug 'liuchengxu/vim-clap'
" Plug 'altercation/vim-colors-solarized'
Plug 'gabrielelana/vim-markdown'

" Go Development
Plug 'fatih/vim-go'

" Common Lisp
Plug 'vlime/vlime', {'rtp': 'vim/'}


call plug#end()

let mapleader=','

" should we perform GUI setup?
if has('termguicolors')
    set termguicolors
endif
let g:use_gui = exists('g:neovide') || has('gui_running') || (has('termguicolors') && &termguicolors)

" Function to source all .vim files in directory
function! SourceDirectory(file)
    for l:fpath in split(globpath(a:file, '*.vim'), '\n')
        exe 'source' l:fpath
    endfor
endfunction

call SourceDirectory(s:vim_settings)
