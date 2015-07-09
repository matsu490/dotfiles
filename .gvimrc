set columns=100			"ウィンドウの幅
set lines=52			"ウィンドウの高さ
colorscheme hybrid	"カラースキーマ設定
set number				"行番号
set encoding=utf-8		"utf-8表示
set backupdir=~/.vim/tmp    "バックアップファイル（~）ディレクトリ
set directory=~/.vim/tmp    "swpファイルディレクトリ
set undodir=~/.vim/tmmp     "un~ファイルディレクトリ
set guifont=Ricty\ Discord\ Regular\ for\ Powerline:h14

"************タブ・インデント関連*************
set noexpandtab			"タブ　＝＞　スペース
set tabstop=4			"タブの表示幅
set shiftwidth=4		"自動インデント幅
set softtabstop=4		"タブの入力幅
set autoindent			"改行時のインデント継続
set smartindent			"改行時に行末に合わせてインデント
set nolist				"タブ文字の可視化（Ｃ＋ｉ）

"************ 検索関連 *************"
set ignorecase			"大文字小文字を区別しない
set smartcase			"検索文字に大文字がある場合大文字小文字を区別
set incsearch			"インクリメンタルサーチ
set hlsearch			"検索マッチテキストをハイライト

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"************ NeoBundle *************
set nocompatible
filetype off

if has('vim_starting')
 set runtimepath+=~/.vim/bundle/neobundle.vim
 call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'jistr/vim-nerdtree-tabs'

filetype plugin on
filetype indent on

"************エイリアス*************
noremap j gj
noremap k gk
noremap H 10h
noremap J 20j
noremap K 20k
noremap L 10l
noremap gr gT
nnoremap <Space> i<Space><Esc>
nnoremap <Tab> I<Tab><Esc>
nnoremap <Return> o<Esc>
nnoremap <C-e> :NERDTreeTabsToggle<CR>
