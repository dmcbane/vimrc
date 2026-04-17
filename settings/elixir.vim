" Format Elixir files on save
augroup filetype_ex
  autocmd!
  autocmd BufWritePre *.ex,*.exs execute "!mix format %"
augroup END

