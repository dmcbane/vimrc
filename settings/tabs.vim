filetype on

" by default, the indent is 2 spaces. 
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for js/coffee/jade files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab

" for golang files, 4 spaces
autocmd Filetype go setlocal ts=4 sw=4 sts=4 expandtab
