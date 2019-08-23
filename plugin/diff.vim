" Diff options
" set diffopt+=iwhite
set diffopt+=vertical
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

" vim-repeat compatible diffing maps
noremap <silent> <Plug>DiffGet :diffget <CR> :diffupdate <CR> :call repeat#set("\<Plug>DiffGet", 0)<CR>
noremap <silent> <Plug>DiffPut :diffput <CR> :diffupdate <CR >:call repeat#set("\<Plug>DiffPut", 0)<CR>


" views
nnoremap <silent> <Leader>dg :Gdiff <cr>
nnoremap <silent> <Leader>ds :DiffChangesDiffToggle <cr>

nmap do <Plug>DiffGet
vmap do <Plug>DiffGet
nmap dp <Plug>DiffPut
vmap dp <Plug>DiffPut
