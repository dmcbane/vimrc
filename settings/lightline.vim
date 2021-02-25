let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ],
      \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
      \            ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype' ]
      \            ]
      \ },
      \ 'component': { 'charvaluehex': '0x%B' },
      \ 'component_function': { 'fileformat': 'LightlineFileformat',
      \                         'filetype': 'LightlineFiletype',
      \                         'gitbranch': 'fugitive#head',
      \                         'readonly': 'LightlineReadonly',
      \                       },
      \ }

" don't show readonly for help buffers
function! LightlineReadonly()
    return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction
" don't show fileformat for narrow windows
function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction
" don't show filetype for narrow windows
function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
