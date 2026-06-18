function! EditInitializationFiles()
    exe 'edit $MYVIMRC'
    let l:configpath = fnamemodify($MYVIMRC, ':p:h')
    let l:vim_settings = l:configpath . '/settings'
    let l:vimrc = l:configpath . '/vimrc'

    if filereadable(l:vimrc) && !(bufloaded(fnamemodify(l:vimrc, ':p')))
        exe 'tabnew ' . l:vimrc
    endif

    " Get all files in directory
    let l:all_files = split(globpath(l:vim_settings, '*'), "\n")
    
    " Filter down to only .txt or .md extensions
    for s:fpath in sort(filter(all_files, 'v:val =~ "\\.\\(vim\\|plug\\)$"'))
    "" for s:fpath in split(globpath(l:vim_settings, '*.vim'), '\n')
        exe 'tabnew ' . s:fpath
    endfor
endfunction

command! -nargs=0 EditInitFiles call EditInitializationFiles()

nnoremap <Leader>v :EditInitFiles<cr>

" Reloads vimrc after saving but keep cursor position
if !exists('*ReloadVimrc')
    fun! ReloadVimrc()
        let save_cursor = getcurpos()
        source $MYVIMRC
        call setpos('.', save_cursor)
    endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()


