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


"-----------------------------------------
" Plugin Mappings--- {{{1
"-----------------------------------------

" coc-plugin {{{2
"-----------------------------------------

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Fixing 'delimitMate' plugin's <S-Tab> mapping to work with coc
	" This does Not help -> imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"
	" despite <S-tab> in delimitMate.vim is `imap` not `inoremap`
	" But following works: e.g. jumps out of `(|)`:
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<Plug>delimitMateS-Tab"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Navigate snippet placeholders using tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'


" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
"Error w/ c-r was Fixed by vim upgrade 
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.

" NOTE: following Fixes interference with  'Raimondi/delimitMate'
" delimitMate_expand_cr feature (going to a new line between braces after
" <cr>) with coc as found out in report by :DelimitMateTest
" Alternative: use vim native ins-completion maps <c-y> (yes) or <c-e> (end) 
"
" if has('patch8.1.1068')
"	" ISSUE: Disabled this if block since after vim update and plugin updates 
"	" <CR> does not act reliably when an entry is selected from the pum (popup
"	" menue) sometimes insidee expanded snippet.
"
"   " Use `complete_info` if your (Neo)Vim version supports it.
"   " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"   " Note: Use `imap` instead of `inoremap` to further evaluate mapping in
"   " returned expression (for <Plug>delimitMateCR)
"   imap <expr> <cr> complete_info()["selected"] != "-1" 
" 	\ ? "\<C-y>" 
" 	\ : "\<C-g>u\<Plug>delimitMateCR"
" else
  " imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  imap <expr> <cr> pumvisible() 
	\ ? "\<C-y>" 
	\ : "\<C-g>u\<Plug>delimitMateCR"
" endif

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
xmap <leader><leader>f  <Plug>(coc-format-selected)
nmap <leader><leader>f  <Plug>(coc-format-selected)

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
" NOTE: may add also class-objects, see sample in readme

" selections ranges
" Use <C-s> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" Originally <TAB> was used for selectionRange ranges.
" Old Issue: 
" <C-i> is mapped to <TAB> in VIM. This cannot be changed (yet).
" Cannot map tab and C-i separately, C-i, originally is to navigate Vim 
" jumplist with C-o.
" Thus - didabled tab mapping to kip original jumplist navigation.
" link: https://github.com/neoclide/coc.nvim/issues/1089

" Now, instead of <TAB>, <C-s> is mapped
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
"
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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
" 'FooSoft/vim-argwrap' --- {{{2
"-----------------------------------------
" nnoremap <silent> gaw :ArgWrap<CR>
nmap <silent> gA <Plug>(ArgWrapToggle)


"-----------------------------------------
" Filetype specific mappings {{{1
"-----------------------------------------

"-----------------------------------------
" vim-plug {{{2
"-----------------------------------------
" vim-plug filetype mappings (e.g. in PlugStatus)
" `gx` mapping to open GitHub
" Press gx to open the GitHub URL for a plugin or a commit with the default browser.
" example line which will work `- gruvbox: `
function! s:plug_gx()
  let line = getline('.')
  let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
  let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                      \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let uri  = get(get(g:plugs, name, {}), 'uri', '')
  if uri !~ 'github.com'
    return
  endif
  let repo = matchstr(uri, '[^:/]*/'.name)
  let url  = empty(sha) ? 'https://github.com/'.repo
                      \ : printf('https://github.com/%s/commit/%s', repo, sha)
  call netrw#BrowseX(url, 0)
endfunction

augroup PlugGx
  autocmd!
  autocmd FileType vim-plug,vim nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
augroup END

"-----------------------------------------
" `H` mapping to open help docs
function! s:plug_doc()
  let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
  if has_key(g:plugs, name)
    for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
      execute 'tabe' doc
    endfor
  endif
endfunction

augroup PlugHelp
  autocmd!
  autocmd FileType vim-plug nnoremap <buffer> <silent> H :call <sid>plug_doc()<cr>
augroup END

"-----------------------------------------
" :PlugHelp command
" Browse help files and README.md
" Requires fzf.
function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

"-----------------------------------------
" Markdown {{{2 
"-----------------------------------------

"move by visual line, not actual line
autocmd FileType markdown,mkd
	\ nnoremap j gj
	\| nnoremap k gk

"-----------------------------------------
" HTML {{{2 
"-----------------------------------------

" Open HTML file in a browser {{{3
autocmd FileType html
	\ nmap <F5> :w <Bar> !xdg-open %<CR>
	
	"TODO: To fix following
	" \  let open = OpenCommand()
	" \| nmap <F5> :w <Bar> execute '!' . open %<CR>
	" or nmap <F5> :w <Bar> execute '!' . OpenCommand() %<CR>

" use following function to open file - for cross-platform portability:
" @function OpenCommand() {{{
" Return a string that can be used to open URL's (and other things).
" Usage:
" let open = OpenCommand()
" if strlen(open) | execute '!' . open 'http://example.com' | endif
" @see http://www.dwheeler.com/essays/open-files-urls.html
" credit: https://stackoverflow.com/a/21703158/2916845 
function! OpenCommand() " {{{
if has('win32unix') && executable('cygstart')
  return 'cygstart'
elseif has('unix') && executable('xdg-open')
  return 'xdg-open'
elseif (has('win32') || has('win64')) && executable('cmd')
  return 'cmd /c start'
elseif (has('macunix') || has('unix') && system('uname') =~ 'Darwin')
      \ && executable('open')
  return 'open'
else
  return ''
endif
endfun " }}} }}}


"-----------------------------------------
" My Custom mappings {{{1
"-----------------------------------------

" show current working directory (cwd)
nmap <C-g><C-g> :pwd<CR>

"-----------------------------------------
" Customization Functions {{{1
"-----------------------------------------

"-----------------------------------------
" visual-at / macro in visual mode  {{{2
"-----------------------------------------
" run vim macro on a visual selection range 
" credit: https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Go to last position {{{2
" Jumps to the last known position in a file after opening it
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

