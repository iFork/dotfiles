

" Plugin Customization / Tuning {{{1
"-----------------------------------------
"
"Fix NERDTree issue with vim seessions {{{2
"_________________________________________
"
"credit: https://stackoverflow.com/a/42462073
"Alternative: use vim-session plugin 
"
fun! Mksession(name)
    let need_tree = g:NERDTree.IsOpen()
    NERDTreeClose
    execute "mksession! " . a:name
    if need_tree
        call writefile(readfile(a:name)+['NERDTree'], a:name)
        NERDTree
    endif
endfun

command! -nargs=1 Mksession call Mksession(<f-args>)

"Idea: Instead of NERDTreeClose, I prefer using tabs NERDTreeTabsClose method 
"used by vim-nerdtree-tabs. This combination also works flawlessly for multiple tabs sessions.
"
"Alternative: 2:
" " Save session on quitting Vim
" autocmd VimLeave * NERDTreeClose
" autocmd VimLeave * mksession! [filename]
"
" " Restore session on starting Vim
" autocmd VimEnter * call MySessionRestoreFunction()
" autocmd VimEnter * NERDTree"
