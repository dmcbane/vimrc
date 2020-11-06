
function! EditInitializationFiles()
    exe 'edit $MYVIMRC'
    if has('nvim')
        if exists(fnamemodify(stdpath('config') . '/settings', ':p'))
            for s:fpath in split(globpath(fnamemodify(stdpath('config') .
                '/settings', ':p'), '*.vim'), '\n')
                exe 'tabnew' s:fpath
            endfor
        endif
    else
        if isdirectory(expand('~/.vim/settings'))
            for s:fpath in split(globpath(expand('~/.vim/settings'), '*.vim'), '\n')
                exe 'tabnew' s:fpath
            endfor
        endif
        if isdirectory(expand('~/vimfiles/settings'))
            for s:fpath in split(globpath(expand('~/vimfiles/settings'), '*.vim'), '\n')
                exe 'tabnew' s:fpath
            endfor
        endif
    endif
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


