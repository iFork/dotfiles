" Hints: start fold markers (fmr) used. Voom may outline this.

"Key Mappings
"-----------------------------------------
" Variables, Settings {{{1
"-----------------------------------------
"let maplocalleader = '.' 
"let mapleader = ',' " default is \ ( '\\', as \ is escape char )
"NOTE: if leader is \, type \\ only if you give no preceeding count,
"otherwise type [count]\... but NOT [count]\\... Escaping does not needed in
"case of 

"NOTE: Do not put comments on the same line with mappings

" Cheatlist: Use command e.g. ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

" Plugin Mappings--- {{{1
"-----------------------------------------

" coc-plugin {{{2
"-----------------------------------------

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
"Error w/ c-r was Fixed by vim upgrade 
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" NOTE: <C-i> is mapped to <TAB> in VIM. This cannot be changed (yet).
" Cannot map tab and C-i separately, C-i, originally is to navigate Vim 
" jumplist with C-o.
" Thus - didabled tab mapping to kip original jumplist navigation.
" Issue: link: https://github.com/neoclide/coc.nvim/issues/1089
" Consider remapping.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>



"-----------------------------------------
" NERDTree plugin {{{2
"-----------------------------------------
"nnoremap <C-n> :NERDTreeToggle<CR>
"nnoremap <S-N> :NERDTreeFocus<CR>
"nnoremap <S-N> :NERDTreeFind<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR> 
	"Gnome and similar terminals confuse <S-F2> (-F3/F4 .. but not Shift-F8 )
	" with Q which enters ex mode, 
	" while Konsloe terminal appepts Shift-F2 as such (but my konsole
	"has problem diplaying bold text. //FIXME later 
	

"-----------------------------------------
" Tagbar plugin {{{2
"-----------------------------------------
nnoremap <F8> :TagbarToggle<CR>
nnoremap <S-F8> :TagbarOpen fj<CR> 
	"focus when opening and jump when open
	

"-----------------------------------------
" vim-easy-align {{{2
"-----------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-----------------------------------------
" vim-easymotion {{{2
"-----------------------------------------
"changing default <Leader><Leader> prefix 
"Note: this interferes with  other plugin's (coc?) `\f` mapping
"(`\f` is overridden)
map <Leader> <Plug>(easymotion-prefix)

" let g:EasyMotion_do_mapping = 0 " Disable default mappings

" "s is bidirectional find motion, you can move to anywhere with it.
" " Jump to anywhere you want with minimal keystrokes, with just one key binding.
" " `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" " or
" " `s{char}{char}{label}`
" " Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-overwin-f2)
" " JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)


"-----------------------------------------
" Filetype specific mappings {{{1
"-----------------------------------------

"-----------------------------------------
" 	Markdown specific line rules {{{3 
"-----------------------------------------

"move by visual line, not actual line
autocmd FileType markdown,mkd
	\ nnoremap j gj
	\| nnoremap k gk

"-----------------------------------------
" visual-at / macro in visual mode  {{{1
"-----------------------------------------
" run vim macro on a visual selection range 
" credit: https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


