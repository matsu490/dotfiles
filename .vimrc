"===========================================================
" For Mac OS X
"===========================================================
if has('mac')
    " ******************************************************
    " Standard settings
    " ******************************************************
    "set columns=100        " Window width (iTerm2で表示に不具合があるため無効化)
    "set lines=52           " Window height（iTerm2で表示に不具合があるため無効化）
    set number              " represent row number
    set laststatus=2        " status line
    set showtabline=2
    set noshowmode
    set backspace=start,eol,indent  "バックスペースの設定
    set clipboard=unnamed,autoselect    "ヤンクとクリップボードの共有
    set backupdir=~/.vim_tmp    "バックアップファイル（~）ディレクトリ
    set directory=~/.vim_tmp    "スワップファイルディレクトリ
    set undodir=~/.vim_tmp      " .un~（undoファイル）ディレクトリ
    set wildmenu                "補完時にワイルドメニューを表示する
    set wildmode=longest:full   "補完方法の設定

    "カラースキーマ設定
    "set t_Co=256
    "syntax enable 
    "set background=dark
    "colorscheme solarized

    "Powerline用フォント設定
    "let g:Powerline_symbols = 'fancy'
    set t_Co=256
    let g:Powerline_symbols = 'compatible'

    " ******************************************************
    " Tab/indent settings
    " ******************************************************
    set expandtab			"タブ＝＞スペース
    set tabstop=4			"タブの表示幅
    set shiftwidth=4		"自動インデント幅
    set softtabstop=4		"タブの入力幅
    set autoindent			"改行時のインデント継続
    set smartindent			"改行時に行末に合わせてインデント
    set nolist				"タブ文字の可視化（Ｃ＋ｉ）

    " ******************************************************
    " Searching settings
    " ******************************************************
    set ignorecase			"大文字小文字を区別しない
    set smartcase			"検索文字に大文字がある場合大文字小文字を区別
    set incsearch			"インクリメンタルサーチ
    set hlsearch			"検索マッチテキストをハイライト
    " バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
    cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
    cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

    " ******************************************************
    " NeoBundle
    " ******************************************************
    set nocompatible
    filetype off
    if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim
    endif
    call neobundle#begin(expand('~/.vim/bundle'))

    " Colorscheme plugins
    NeoBundle 'b4b4r07/solarized.vim', { "base" : $HOME."/.vim/colors" }
    NeoBundle 'nanotech/jellybeans.vim', { "base" : $HOME."/.vim/colors" }
    NeoBundle 'tomasr/molokai', { "base" : $HOME."/.vim/colors" }
    NeoBundle 'w0ng/vim-hybrid', { "base" : $HOME."/.vim/colors" }

    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'thinca/vim-template'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/neocomplete'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'ujihisa/unite-colorscheme'
    "NeoBundle 'osyo-manga/shabadou.vim'
    "NeoBundle 'osyo-manga/vim-watchdogs'
    "NeoBundle 'kevinw/pyflakes-vim'
    "NeoBundle 'davidhalter/jedi-vim'
    NeoBundle 'jceb/vim-hier'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'jistr/vim-nerdtree-tabs'
    "NeoBundle 'bling/vim-airline'
    "NeoBundle 'alpaca-tc/alpaca_powertabline'
    "NeoBundle 'Lokaltog/powerline', {'rtp' : 'powerline/bindings/vim'}
    "NeoBundle 'Lokaltog/powerline-fontpatcher'
    NeoBundle 'itchyny/lightline.vim'
    NeoBundle 'nathanaelkane/vim-indent-guides'
    call neobundle#end()
    filetype plugin on
    filetype indent on

    " Library: in vimrc {{{1
    " Functions that are described in this section is general functions.
    " It is not general, for example, functions used in a dedicated purpose
    " has been described in the setting position.
    "==============================================================================

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
    "==============================================================================

    " Essentials
    syntax enable
    syntax on

    set number

    " Colorscheme
    set background=dark
    if !has('gui_running')
        set background=dark
    endif
    set t_Co=256
    if &t_Co < 256
        colorscheme default
    else
        if has('gui_running') && !s:is_windows
            " For MacVim, only
            if s:has_plugin('solarized.vim')
                try
                    colorscheme solarized-cui
                catch
                    colorscheme solarized
                endtry
            endif
        else
            " Vim for CUI
            if s:has_plugin('solarized.vim')
                try
                    colorscheme solarized-cui
                catch
                    colorscheme solarized
                endtry
            elseif s:has_plugin('jellybeans.vim')
                colorscheme jellybeans
            elseif s:has_plugin('vim-hybrid')
                colorscheme hybrid
            else
                if s:is_windows
                    colorscheme default
                else
                    colorscheme desert
                endif
            endif
        endif
    endif

    " Plugins: {{{1
    " If you have below plugins, set it.
    "==============================================================================

    "************ syntastic *************
    let g:syntastic_python_checkers = ['flake8']

    " ******************************************************
    " lightline.vim
    " ******************************************************
    if s:has_plugin('lightline.vim') "{{{2
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
                    \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
                    \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"}
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

    " ******************************************************
    " neocomplete
    " ******************************************************
    let g:neocomplete#enable_at_startup = 1

    " ******************************************************
    " watchdogs
    " ******************************************************
    "let g:quickrun_config = {
    "\   'watchdogs_checker/_':{
    "\       'hook/close_quickfix/enable_exit':1,
    "\   },
    "\}
    "call watchdogs#setup(g:quickrun_config)
    "let g:watchdogs_check_BufWritePost_enable = 1
    "let g:watchdogs_check_CursorHold_enable = 1

    " ******************************************************
    " pyflakes-vim
    " ******************************************************
    "let g:pyflakes_use_quickfix = 0

    " ******************************************************
    " vim-template
    " ******************************************************
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

    " ******************************************************
    " vim-indent-guides
    " ******************************************************
    let g:indent_guides_auto_colors=0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=black
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgray
    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_guide_size=1

    " ******************************************************
    " jedi-vim
    " ******************************************************
    autocmd FileType python setlocal completeopt-=preview
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#documentation_command = '<leader>K'
    let g:jedi#rename_command = '<leader>R'

    " ******************************************************
    " Alias settings
    " ******************************************************
    noremap j gj
    noremap k gk
    noremap H 10h
    noremap J 10j
    noremap K 10k
    noremap L 10l
    noremap gr gT
    noremap n nzz
    noremap N Nzz
    inoremap ( ()<Left>
    inoremap { {}<Left>
    inoremap [ []<Left>
    nnoremap <Space> i<Space><Esc>
    nnoremap <Tab> I<Tab><Esc>
    nnoremap <Return> o<Esc>
    nnoremap <C-e> :NERDTreeTabsToggle<CR>
    nnoremap <F5> :<C-u>source ~/.vimrc<CR>

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
    nnoremap sn :<C-u>noh<CR>
    nnoremap sN :<C-u>bn<CR>
    nnoremap sP :<C-u>bp<CR>
    nnoremap st :<C-u>tabnew<CR>
    nnoremap sT :<C-u>Unite tab<CR>
    nnoremap ss :<C-u>sp<CR>
    nnoremap sv :<C-u>vs<CR>
    nnoremap sq :<C-u>q<CR>
    nnoremap sQ :<C-u>bd<CR>
    nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
    nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
    nnoremap su :<C-u>Unite file<CR>
endif

"===========================================================
" For Unix
"===========================================================
if has('unix')
    " ******************************************************
    " Alias settings
    " ******************************************************
    noremap j gj
    noremap k gk
    noremap H 10h
    noremap J 10j
    noremap K 10k
    noremap L 10l
    noremap gr gT
    noremap n nzz
    noremap N Nzz
    inoremap ( ()<Left>
    inoremap { {}<Left>
    inoremap [ []<Left>
    nnoremap <Space> i<Space><Esc>
    nnoremap <Tab> I<Tab><Esc>
    nnoremap <Return> o<Esc>
    nnoremap <C-e> :NERDTreeTabsToggle<CR>
    nnoremap <F5> :<C-u>source ~/.vimrc<CR>

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
    nnoremap sn :<C-u>noh<CR>
    nnoremap sN :<C-u>bn<CR>
    nnoremap sP :<C-u>bp<CR>
    nnoremap st :<C-u>tabnew<CR>
    nnoremap sT :<C-u>Unite tab<CR>
    nnoremap ss :<C-u>sp<CR>
    nnoremap sv :<C-u>vs<CR>
    nnoremap sq :<C-u>q<CR>
    nnoremap sQ :<C-u>bd<CR>
    nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
    nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
    nnoremap su :<C-u>Unite file<CR>
endif

"===========================================================
" For windows 32bit or 64bit
"===========================================================
if has('win32') || has('win64')
    " ***************************************************
    " Standard settings
    " ***************************************************
    set number              "行番号の表示
    set laststatus=2        "ステータスライン表示行数
    set showtabline=2
    set noshowmode
    set backspace=start,eol,indent  "バックスペースの設定
    set clipboard=unnamed,autoselect    "ヤンクとクリップボードの共有
    set backupdir=~/.vim_tmp    "バックアップファイル（~）ディレクトリ
    set directory=~/.vim_tmp    "スワップファイルディレクトリ
    set undodir=~/.vim_tmp      " .un~（undoファイル）ディレクトリ
    set wildmenu                "補完時にワイルドメニューを表示する
    set wildmode=longest:full   "補完方法の設定

    "カラースキーマ設定
    "set t_Co=256
    "syntax enable 
    "set background=dark
    "colorscheme solarized

    "Powerline用フォント設定
    "let g:Powerline_symbols = 'fancy'
    set t_Co=256
    let g:Powerline_symbols = 'compatible'

    " ******************************************************
    " NeoBundle
    " ******************************************************
"    set nocompatible
"    filetype off
"    if has('vim_starting')
"        set runtimepath+=~/.vim/bundle/neobundle.vim
"    endif
"    call neobundle#begin(expand('~/.vim/bundle'))
"    NeoBundleFetch 'Shougo/neobundle.vim'
"    call neobundle#end()
"    filetype plugin on
"    filetype indent on

    " ******************************************************
    " Tab/indent settings
    " ******************************************************
    set expandtab			"タブ＝＞スペース
    set tabstop=4			"タブの表示幅
    set shiftwidth=4		"自動インデント幅
    set softtabstop=4		"タブの入力幅
    set autoindent			"改行時のインデント継続
    set smartindent			"改行時に行末に合わせてインデント
    set nolist				"タブ文字の可視化（Ｃ＋ｉ）

    " ******************************************************
    " Searching settings
    " ******************************************************
    set ignorecase			"大文字小文字を区別しない
    set smartcase			"検索文字に大文字がある場合大文字小文字を区別
    set incsearch			"インクリメンタルサーチ
    set hlsearch			"検索マッチテキストをハイライト
    " バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
    cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
    cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
    " ******************************************************
    " Alias settings
    " ******************************************************
    noremap j gj
    noremap k gk
    noremap H 10h
    noremap J 10j
    noremap K 10k
    noremap L 10l
    noremap gr gT
    noremap n nzz
    noremap N Nzz
    inoremap ( ()<Left>
    inoremap { {}<Left>
    inoremap [ []<Left>
    nnoremap <Space> i<Space><Esc>
    nnoremap <Tab> I<Tab><Esc>
    nnoremap <Return> o<Esc>
    nnoremap <C-e> :NERDTreeTabsToggle<CR>
    nnoremap <F5> :<C-u>source ~/.vimrc<CR>

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
    nnoremap sn :<C-u>noh<CR>
    nnoremap sN :<C-u>bn<CR>
    nnoremap sP :<C-u>bp<CR>
    nnoremap st :<C-u>tabnew<CR>
    nnoremap sT :<C-u>Unite tab<CR>
    nnoremap ss :<C-u>sp<CR>
    nnoremap sv :<C-u>vs<CR>
    nnoremap sq :<C-u>q<CR>
    nnoremap sQ :<C-u>bd<CR>
    nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
    nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
    nnoremap su :<C-u>Unite file<CR>
endif
