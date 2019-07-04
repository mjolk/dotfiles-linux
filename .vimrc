" File   : /home/mjolk/.vimrc
" License: MIT/X11
" Author : Dries Pauwels <2mjolk@gmail.com>
" Date   : do 06 sep 2018 05:15
" Last Modified Date   : vr 14 sep 2018 19:28
"call pathogen#infect() //using vim8... leaving it here in case ever need it
"on pre 8
filetype plugin indent on
syntax on
set nu
autocmd Filetype typescript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=0 expandtab
autocmd FileType javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype c setlocal sw=4 ts=4 sts=0 expandtab
"set guifont=Monaco\ for\ Powerline:h12
"set guifont=Source\ Code\ Pro\ for\ Powerline:h13
"set guifont=Ubuntui\ Mono\ derivative\ Powerline:h13
"set noantialias
set t_Co=256
"set background=dark
colorscheme inkpot2
set nocursorcolumn
syntax sync minlines=256
set exrc
set secure
set re=1
set ttimeoutlen=50
set nowrap
set showmatch
set noignorecase
set hlsearch
set incsearch
set hidden
set backup
set swapfile
set cursorline
set nostartofline
set novisualbell
set ruler
set mouse=a
set laststatus=2
set wildignore+=*/node_modules/*,*.so,*.swp,*.zip,*/vendor/*
let mapleader = ","
"let g:CSApprox_loaded = 1
let g:CSApprox_attr_map = { 'italic' : '', 'sp' : '' }
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
"let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = "quickfix"
let g:go_highlight_fields = 1
let g:go_build_tags = "development"
"autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
"autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
"autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
set completeopt-=preview
let g:inkpot_black_background=1
let g:airline_powerline_fonts = 1
"let g:clang_complete_auto = 0
"let g:clang_complete_copen = 1
"let g:clang_debug = 0
"let g:syntastic_debug = 0
"map <C-n> :NERDTreeToggle<CR>
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = '✗ '
let g:airline#extensions#ycm#warning_symbol = '⚠ '
set statusline+=%{ObsessionStatus()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_go_checkers = ['go']
let g:syntastic_go_checkers = ['go']
"let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['go']}
let g:syntastic_javascript_checkers = ['eslint']
"let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected", "is invalid", "not allowed"]
let g:ctrlp_working_path_mode = 'r'
let g:typescript_indent_disable = 0
let g:tmuxline_preset = {
      \'a'    : ['#S'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'y'    : ['%R', '%a', '%d %B'],
      \'z'    : '♫ #(mpc current)',
      \ 'options':{
      \ 'status-justify': 'left'}
      \}
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|vendor$\|node_modules$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
"let g:ycm_global_ycm_extra_conf = '~/.vim/pack/mjolk/start/.ycm_extra_osx_conf.py'
let g:header_field_author = 'Dries Pauwels'
let g:header_field_author_email = '2mjolk@gmail.com'
let g:header_field_license_id = 'MIT/X11'
let g:header_auto_add_header = 1
let g:header_field_timestamp_format = '%a %d %b %Y %H:%M'
let g:header_field_modified_timestamp = 0
let g:header_field_modified_by = 0
let java_highlight_functions = 1
"let g:ycm_filetype_blacklist = {
"      \ 'go': 1,
"      \}
