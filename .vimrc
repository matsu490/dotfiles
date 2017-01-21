"===============================================================================
" For common environment
"===============================================================================
"*********************************************************************
" Standard settings
"*********************************************************************
set number              " represent row number
set laststatus=2        " status line
set showtabline=2
set scrolloff=3
set noshowmode
set backspace=start,eol,indent  "バックスペースの設定
set clipboard=unnamed,autoselect    "ヤンクとクリップボードの共有
set backupdir=~/.vim_tmp    "バックアップファイル（~）ディレクトリ
set directory=~/.vim_tmp    "スワップファイルディレクトリ
set undodir=~/.vim_tmp      " .un~（undoファイル）ディレクトリ
set wildmenu                "補完時にワイルドメニューを表示する
set wildmode=longest:full   "補完方法の設定

"*********************************************************************
" Tab/indent settings
"*********************************************************************
set expandtab			"タブ＝＞スペース
set tabstop=4			"タブの表示幅
set shiftwidth=4		"自動インデント幅
set softtabstop=4		"タブの入力幅
set autoindent			"改行時のインデント継続
set smartindent			"改行時に行末に合わせてインデント
set nolist				"タブ文字の可視化（Ｃ＋ｉ）

"*********************************************************************
" Searching settings
"*********************************************************************
set ignorecase			"大文字小文字を区別しない
set smartcase			"検索文字に大文字がある場合大文字小文字を区別
set incsearch			"インクリメンタルサーチ
set hlsearch			"検索マッチテキストをハイライト
" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"*********************************************************************
" Alias settings
"*********************************************************************
noremap j gj
noremap k gk
noremap H 10h
noremap J 10j
noremap K 10k
noremap L 10l
noremap gr gT
noremap n nzz
noremap N Nzz
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
nnoremap <Space> i<Space><Esc>
nnoremap <Tab> I<Tab><Esc>
nnoremap <Return> o<Esc>
nnoremap <S-Return> O<Esc>
nnoremap <F5> :<C-u>source ~/.vimrc<CR>
nnoremap <F6> :<C-u>e ~/.vimrc<CR>

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-W>H
nnoremap s+ <C-w>+
nnoremap s- <C-w>-
nnoremap s< <C-w><
nnoremap s> <C-w>>
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sp :<C-u>setl paste! paste?<CR>
nnoremap sn :<C-u>noh<CR>
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sf :<C-u>VimFiler<CR>
nnoremap sF :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap su :<C-u>Unite file<CR>

"*********************************************************************
" Color scheme
"*********************************************************************
" Library: in vimrc {{{1
" Functions that are described in this section is general functions.
" It is not general, for example, functions used in a dedicated purpose
" has been described in the setting position.
"-----------------------------------------------------------
" func s:has_plugin() {{{2
" @params string
" @return bool
"
function! s:has_plugin(name)
    " Check {name} plugin whether there is in the runtime path
    let nosuffix = a:name =~? '\.vim$' ? a:name[:-5] : a:name
    let suffix   = a:name =~? '\.vim$' ? a:name      : a:name . '.vim'
    return &rtp =~# '\c\<' . nosuffix . '\>'
                \   || globpath(&rtp, suffix, 1) != ''
                \   || globpath(&rtp, nosuffix, 1) != ''
                \   || globpath(&rtp, 'autoload/' . suffix, 1) != ''
                \   || globpath(&rtp, 'autoload/' . tolower(suffix), 1) != ''
endfunction

" Appearance: {{{1
" In this section, interface of Vim, that is, colorscheme, statusline and
" tabpages line is set.
"-----------------------------------------------------------

" Essentials
syntax enable
syntax on

" Colorscheme
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_mac = has('mac')
let s:is_unix = has('unix')

if !has('gui_running')
    set background=dark
endif

set t_Co=256
if &t_Co < 256
    colorscheme desert
else
    if s:is_mac
        colorscheme solarized
    elseif s:is_unix
        colorscheme default
    elseif s:is_windows
        colorscheme default
    else
        colorscheme default
    endif
endif

" Plugins: {{{1
" If you have below plugins, set it.
"-----------------------------------------------------------

"===============================================================================
" For Mac OS X
"===============================================================================
if has('mac')
"*********************************************************************
" dein
"*********************************************************************
if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make -f make_mac.mak'})
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/unite.vim')
call dein#add('thinca/vim-template')
call dein#add('scrooloose/syntastic')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('itchyny/lightline.vim')
call dein#add('davidhalter/jedi-vim')
call dein#end()
filetype plugin on
filetype indent on

"*********************************************************************
" syntastic
"*********************************************************************
set pythondll=/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/Python
let g:evervim_devtoken='S=s129:U=d71068:E=15d461e2d76:C=155ee6d00e8:P=1cd:A=en-devtoken:V=2:H=bcc13d20377833b0b1413fcc213a3d57'
nnoremap <Leader>l :EvervimNotebookList<CR>
nnoremap <Leader>s :EvervimSearchByQuery<Space>
nnoremap <Leader>c :EvervimCreateNote<CR>
nnoremap <Leader>t :EvervimListTags<CR>

"*********************************************************************
" syntastic
"*********************************************************************
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501,F841,F403"'
"let g:syntastic_python_flake8_args = '--ignore="E501,F403"'

"*********************************************************************
" lightline.vim
"*********************************************************************
if s:has_plugin('lightline.vim') "{{{2
    if has('gui_running')
        let g:lightline = {
                    \ 'colorscheme': 'solarized',
                    \ 'mode_map': {'c': 'NORMAL'},
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ],
                    \             [ 'readonly', 'filepath', 'filename', 'modified' ] ],
                    \   'right' : [ [ 'lineinfo' ],
                    \               [ 'percent' ],
                    \               [ 'filetype', 'fileencoding', 'fileformat' ] ]
                    \ },
                    \ 'component_function': {
                    \   'modified': 'MyModified',
                    \   'readonly': 'MyReadonly',
                    \   'fugitive': 'MyFugitive',
                    \   'filepath': 'MyFilepath',
                    \   'filename': 'MyFilename',
                    \   'fileformat': 'MyFileformat',
                    \   'filetype': 'MyFiletype',
                    \   'fileencoding': 'MyFileencoding',
                    \   'mode': 'MyMode',
                    \   'date': 'MyDate'
                    \ }
                    \ }
    else
        let g:lightline = {
                    \ 'colorscheme': 'solarized',
                    \ 'mode_map': {'c': 'NORMAL'},
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ],
                    \             [ 'readonly', 'filepath', 'filename', 'modified' ] ],
                    \   'right' : [ [ 'lineinfo' ],
                    \               [ 'percent' ],
                    \               [ 'filetype', 'fileencoding', 'fileformat' ] ]
                    \ },
                    \ 'component_function': {
                    \   'modified': 'MyModified',
                    \   'readonly': 'MyReadonly',
                    \   'fugitive': 'MyFugitive',
                    \   'filepath': 'MyFilepath',
                    \   'filename': 'MyFilename',
                    \   'fileformat': 'MyFileformat',
                    \   'filetype': 'MyFiletype',
                    \   'fileencoding': 'MyFileencoding',
                    \   'mode': 'MyMode',
                    \   'date': 'MyDate'
                    \ },
                    \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
                    \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"}
                    \ }
    endif

    function! MyModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
    endfunction

    function! MyFilename()
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft == 'unite' ? unite#get_status_string() :
                    \  &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
        if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? "\ue0a0"._ : ''
        endif
        return ''
    endfunction

    function! MyFilepath()
        return substitute(getcwd(), $HOME, '~', '')
    endfunction

    function! MyFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    function! MyDate()
        return strftime("%Y/%m/%d %H:%M")
    endfunction

endif

"*********************************************************************
" neocomplete
"*********************************************************************
let g:neocomplete#enable_at_startup = 1

"*********************************************************************
" vimfiler
"*********************************************************************
let g:vimfiler_enable_auto_cd = 1

"*********************************************************************
" vim-template
"*********************************************************************
"テンプレート中に含まれる特定文字列を置き換える
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
"    silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
"テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |     silent! execute 'normal! "_da>'
    \ | endif

"*********************************************************************
" vim-indent-guides
"*********************************************************************
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgray
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

"*********************************************************************
" jedi-vim
"*********************************************************************
autocmd FileType python setlocal completeopt-=preview
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#documentation_command = '<leader>K'
let g:jedi#rename_command = '<leader>R'


"===============================================================================
" For Unix
"===============================================================================
elseif has('unix')
"*********************************************************************
" Standard settings
"*********************************************************************
colorscheme solarized
set t_Co=256
set background=dark

"*********************************************************************
" NeoBundle
"*********************************************************************
set nocompatible
filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimproc'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
"NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'b4b4r07/solarized.vim', { "base" : $HOME."/.vim/colors" }
call neobundle#end()
filetype plugin on
filetype indent on

"*********************************************************************
" syntastic
"*********************************************************************
let g:syntastic_python_checkers = ['flake8']

"*********************************************************************
" lightline.vim
"*********************************************************************
function! s:has_plugin(name)
    " Check {name} plugin whether there is in the runtime path
    let nosuffix = a:name =~? '\.vim$' ? a:name[:-5] : a:name
    let suffix   = a:name =~? '\.vim$' ? a:name      : a:name . '.vim'
    return &rtp =~# '\c\<' . nosuffix . '\>'
                \   || globpath(&rtp, suffix, 1) != ''
                \   || globpath(&rtp, nosuffix, 1) != ''
                \   || globpath(&rtp, 'autoload/' . suffix, 1) != ''
                \   || globpath(&rtp, 'autoload/' . tolower(suffix), 1) != ''
endfunction

if s:has_plugin('lightline.vim')
    let g:lightline = {
                \ 'colorscheme': 'solarized',
                \ 'mode_map': {'c': 'NORMAL'},
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'readonly', 'filepath', 'filename', 'modified' ] ],
                \   'right' : [ [ 'lineinfo', 'percent' ],
                \               [ 'filetype', 'fileencoding', 'fileformat' ] ]
                \ },
                \ 'component_function': {
                \   'modified': 'MyModified',
                \   'readonly': 'MyReadonly',
                \   'fugitive': 'MyFugitive',
                \   'filepath': 'MyFilepath',
                \   'filename': 'MyFilename',
                \   'fileformat': 'MyFileformat',
                \   'filetype': 'MyFiletype',
                \   'fileencoding': 'MyFileencoding',
                \   'mode': 'MyMode',
                \   'date': 'MyDate'
                \ },
                \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2 "},
                \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3 "}
                \ }

    function! MyModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '\ue0a2' : ''
    endfunction

    function! MyFilename()
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft == 'unite' ? unite#get_status_string() :
                    \  &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
        if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? '\ue0a0'._ : ''
        endif
        return ''
    endfunction

    function! MyFilepath()
        return substitute(getcwd(), $HOME, '~', '')
    endfunction

    function! MyFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    function! MyDate()
        return strftime("%Y/%m/%d %H:%M")
    endfunction

endif

"*********************************************************************
" vim-indent-guides
"*********************************************************************
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgray
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

"*********************************************************************
" jedi-vim
"*********************************************************************
autocmd FileType python setlocal completeopt-=preview
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#documentation_command = '<leader>K'
let g:jedi#rename_command = '<leader>R'

"===============================================================================
" For windows 32bit or 64bit
"===============================================================================
elseif has('win32') || has('win64')
"*********************************************************************
" Standard settings
"*********************************************************************
colorscheme solarized
set background=dark

"*********************************************************************
" dein
"*********************************************************************
if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/vimproc.vim')
call dein#add('Shougo/vimfiler')
call dein#add('thinca/vim-template')
call dein#add('scrooloose/syntastic')
call dein#add('itchyny/lightline.vim')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('davidhalter/jedi-vim')
call dein#end()
filetype plugin on
filetype indent on

"*********************************************************************
" neocomplete
"*********************************************************************
let g:neocomplete#enable_at_startup = 1

"*********************************************************************
" syntastic
"*********************************************************************
let g:syntastic_python_checkers = ['flake8']

"*********************************************************************
" vimfiler
"*********************************************************************
let g:vimfiler_enable_auto_cd = 1

"*********************************************************************
" lightline.vim
"*********************************************************************
function! s:has_plugin(name)
    " Check {name} plugin whether there is in the runtime path
    let nosuffix = a:name =~? '\.vim$' ? a:name[:-5] : a:name
    let suffix   = a:name =~? '\.vim$' ? a:name      : a:name . '.vim'
    return &rtp =~# '\c\<' . nosuffix . '\>'
                \   || globpath(&rtp, suffix, 1) != ''
                \   || globpath(&rtp, nosuffix, 1) != ''
                \   || globpath(&rtp, 'autoload/' . suffix, 1) != ''
                \   || globpath(&rtp, 'autoload/' . tolower(suffix), 1) != ''
endfunction
if s:has_plugin('lightline.vim')
    let g:lightline = {
                      \ 'colorscheme': 'solarized',
                      \ 'mode_map': {'c': 'NORMAL'},
                      \ 'active': {
                      \   'left': [ [ 'mode', 'paste' ],
                      \             [ 'readonly', 'filepath', 'filename', 'modified' ] ],
                      \   'right' : [ [ 'lineinfo', 'percent' ],
                      \               [ 'filetype', 'fileencoding', 'fileformat' ] ]
                      \ },
                      \ 'component_function': {
                      \   'modified': 'MyModified',
                      \   'readonly': 'MyReadonly',
                      \   'fugitive': 'MyFugitive',
                      \   'filepath': 'MyFilepath',
                      \   'filename': 'MyFilename',
                      \   'fileformat': 'MyFileformat',
                      \   'filetype': 'MyFiletype',
                      \   'fileencoding': 'MyFileencoding',
                      \   'mode': 'MyMode',
                      \   'date': 'MyDate'
                      \ },
                    \ }

    function! MyModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'ReadOnly' : ''
    endfunction

    function! MyFilename()
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft == 'unite' ? unite#get_status_string() :
                    \  &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
        if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? 'Fugitive'._ : ''
        endif
        return ''
    endfunction

    function! MyFilepath()
        return substitute(getcwd(), $HOME, '~', '')
    endfunction

    function! MyFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    function! MyDate()
        return strftime("%Y/%m/%d %H:%M")
    endfunction

endif

"*********************************************************************
" vim-indent-guides
"*********************************************************************
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgray
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1


"*********************************************************************
" vim-template
"*********************************************************************
"テンプレート中に含まれる特定文字列を置き換える
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
"    silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
"テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |     silent! execute 'normal! "_da>'
    \ | endif

"*********************************************************************
" jedi-vim
"*********************************************************************
autocmd FileType python setlocal completeopt-=preview
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#documentation_command = '<leader>K'
let g:jedi#rename_command = '<leader>R'

endif
