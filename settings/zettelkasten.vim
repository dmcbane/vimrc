
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

let g:zk_path = expand('~\Documents\Secondary')

nnoremap <Leader>zd :Texplore g:zk_path
nnoremap <Leader>zs :ZettelKastenSaveNew
nnoremap <Leader>zu :DatetimeUUID
nnoremap <Leader>zf :ZettelKastenFind
