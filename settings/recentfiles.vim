if get(w:, 'quickfix_title') =~# 'Oldfiles'
    nnoremap <buffer> <CR> <CR>:cclose<CR>
endif
