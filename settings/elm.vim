let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 1
let g:elm_make_show_warnings = 1
let g:elm_jump_to_error = 1
let g:elm_format_fail_silently = 0

let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

autocmd Filetype elm setlocal ts=4 sw=4 sts=4 expandtab nowrap

autocmd Filetype html setlocal ts=4 sw=4 sts=0 expandtab


