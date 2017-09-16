"autocmd BufWritePre *.go :silent %!/usr/local/go/bin/gofmt
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd Filetype typescript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=0 expandtab
autocmd FileType javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType go setlocal ts=8 sw=8 noexpandtab
call pathogen#infect()
filetype plugin indent on
syntax on 
set nu
"set guifont=Monaco\ for\ Powerline:h12
"set guifont=Source\ Code\ Pro\ for\ Powerline:h13
"set guifont=Ubuntui\ Mono\ derivative\ Powerline:h13
"set noantialias
set t_Co=256
set background=dark
colorscheme inkpot2
set nocursorcolumn
syntax sync minlines=256
set re=1
set nowrap
set showmatch
set noignorecase
set hlsearch
set incsearch
set hidden
set nobackup
set noswapfile
set cursorline
set nostartofline
set novisualbell
set ruler
set mouse=a
set laststatus=2
set wildignore+=*/node_modules/*,*.so,*.swp,*.zip
let mapleader = ","
"let g:CSApprox_loaded = 1
let g:CSApprox_attr_map = { 'bold' : 'BOLD', 'italic' : '', 'sp' : '' }
let delimitMate_expand_cr = 1
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
"autocmd FileType * nested :call tagbar#autoopen(0)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = "quickfix"
"let g:go_highlight_fields = 1
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
set completeopt-=preview
"let g:SuperTabDefaultCompletionType = "context"
let g:inkpot_black_background=1
"let g:SuperTabDefaultCompletionType="<c-x><c-o>"
let g:airline_powerline_fonts = 1
"let g:clang_complete_auto = 0
"let g:clang_complete_copen = 1
"let g:clang_debug = 0
"let g:syntastic_debug = 0
"map <C-n> :NERDTreeToggle<CR>
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
set statusline+=%{ObsessionStatus()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go']
"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck', 'go']
"let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['go']}
let g:syntastic_javascript_checkers = ['eslint']
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_use_local_typescript = 0
let g:syntastic_typescript_checkers = ['tsuquyomi']
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected", "is invalid", "not allowed"]
let g:ctrlp_working_path_mode = 'r'
let g:typescript_indent_disable = 0
"if has("autocmd")
"  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"    au InsertEnter,InsertChange *
"	\ if v:insertmode == 'i' | 
"	\   silent execute '!echo -ne "\e[6 q"' | redraw! |
"	\ elseif v:insertmode == 'r' |
"	\   silent execute '!echo -ne "\e[4 q"' | redraw! |
"	\ endif
"      au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
"endif
let g:tmuxline_preset = {
      \'a'    : ['#S'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'y'    : ['%R', '%a', '%B'],
      \'z'    : '♫ #(mpc current)',
      \ 'options':{
      \ 'status-justify': 'left'}
      \}
