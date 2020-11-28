" Insert 
function! UUIDtoBuffer()
pyx << EOF
import vim
from uuid import uuid4
vim.current.buffer.append(str(uuid4()), vim.current.window.cursor[0])
EOF
endfunction

command! -nargs=0 UUID call UUIDtoBuffer()

function! UUIDtoClipboard()
pyx << EOF
import vim
from uuid import uuid4
vim.command("let @+='%s'" % (str(uuid4())))
EOF
endfunction

command! -nargs=0 CopyUUID call UUIDtoClipboard()

function! CurrentDatetimeUUIDtoBuffer()
pyx << EOF
import vim
from datetime import datetime
from uuid import uuid4
now = datetime.now()
now_str = now.strftime("%Y%m%d%H%M%S")
uid = str(uuid4())
vim.current.buffer.append(now_str + "_" + uid, vim.current.window.cursor[0])
EOF
endfunction

command! -nargs=0 DatetimeUUID call CurrentDatetimeUUIDtoBuffer()

function! CurrentDatetimeUUIDtoClipboard()
pyx << EOF
import vim
from datetime import datetime
from uuid import uuid4
now = datetime.now()
now_str = now.strftime("%Y%m%d%H%M%S")
uid = str(uuid4())
vim.command("let @+='%s'" % (now_str + "_" + uid))
EOF
endfunction

command! -nargs=0 CopyDatetimeUUID call CurrentDatetimeUUIDtoClipboard()

function! ZettelKastenCreateNewBuffer()
pyx << EOF
import vim
vim.buffers
EOF
endfunction
"" augroup ProjectDrawer
""     autocmd!
""     autocmd VimEnter * :Vexplore
"" augroup END

command! -nargs=0 ZettelKastenCreateNewNote call ZettelKastenCreateNewBuffer()

let g:zk_path = expand('~\Documents\Secondary')

nnoremap ub  :UUID<CR>
nnoremap uc  :CopyUUID<CR>
nnoremap dub :DatetimeUUID<CR>
nnoremap duc :CopyDatetimeUUID<CR>
" nnoremap <Leader>zd :Vexplore <c-r>=g:zk_path<CR><CR>
nnoremap <Leader>zd :exec "tabnew \| Vexplore ".g:zk_path<CR>
nnoremap <Leader>zn :ZettelKastenCreateNewNote<CR>
"" nnoremap <Leader>zs :ZettelKastenSaveNew<CR>
"" nnoremap <Leader>zu :DatetimeUUID<CR>
"" nnoremap <Leader>zf :ZettelKastenFind<CR>
