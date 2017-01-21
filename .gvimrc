"===========================================================
" For Mac OS X
"===========================================================
if has('mac')
    set columns=100			"ウィンドウの幅
    set lines=52			"ウィンドウの高さ
    colorscheme solarized	"カラースキーマ設定
    set encoding=utf-8		"utf-8表示
    set guifont=Ricty\ Discord\ Regular\ for\ Powerline:h14

"===========================================================
" For Unix
"===========================================================
elseif has('unix')
    set columns=100			"ウィンドウの幅
    set lines=52			"ウィンドウの高さ
    colorscheme solarized	"カラースキーマ設定
    set encoding=utf-8		"utf-8表示

"===========================================================
" For windows 32bit or 64bit
"===========================================================
elseif has('win32') || has('win64')
    set guifont=MyricaM\ M:h13
    set columns=80			"ウィンドウの幅
    set lines=52			"ウィンドウの高さ
    set background=dark
    colorscheme solarized	"カラースキーマ設定
endif
