" Gcompare
" Workaround for https://github.com/tpope/vim-fugitive/issues/425
function! _gcompare_gdiff()
    let winheight = winheight(winnr())
    let branchname=b:branchName
    let filename = substitute(getline('.'), '^\w*\s*\(.*\)', '\1', '')
    let gitroot = b:gitroot
    only
    wincmd s
    execute 'resize '.winheight
    wincmd j
    execute 'cd '.gitroot
    execute 'edit '.filename
    execute 'Gdiff '.branchname
endfunction

function! _gcompare_reload()

    setlocal modifiable

    let position = line('.')
    execute '%d'

    call append(line(1), '#git diff --name-status '.b:branchName)
    execute 'silent read! git diff --name-status '.b:branchName

    execute ':'.position

    setlocal nomodifiable

endfunction

function! s:EditComplete(A,L,P) abort
  return map(fugitive#repo().superglob(a:A), 'fnameescape(v:val)')
endfunction

function! Gcompare(branchName)
    let gitroot = fugitive#repo().tree()

    new
    silent! wincmd P

    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile

    let b:branchName=a:branchName
    let b:gitroot = gitroot

    call _gcompare_reload()

    resize 12

    nmap <buffer> D :call _gcompare_gdiff()<cr>
    nmap <buffer> r :call _gcompare_reload()<cr>
    nmap <buffer> q :q<cr>
endfunction

command! -nargs=1 -complete=customlist,s:EditComplete Gcompare call Gcompare(<q-args>)
